// Klubrádió Image Proxy - CORS-enabled image proxy for Flutter Web
// This function proxies images from klubradio.hu domains to avoid CORS errors

import "jsr:@supabase/functions-js/edge-runtime.d.ts"

const ALLOWED_HOSTS = [
  'www.klubradio.hu',
  'klubradio.hu',
  'images.klubradio.hu',
  'cdn.klubradio.hu',
]

Deno.serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response(null, {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type',
      },
    })
  }

  const url = new URL(req.url).searchParams.get('url')

  // Validate URL parameter
  if (!url) {
    return new Response('Missing url parameter', { status: 400 })
  }

  // Parse and validate target URL
  let targetUrl: URL
  try {
    targetUrl = new URL(url)
  } catch {
    return new Response('Invalid URL', { status: 400 })
  }

  // Only allow klubradio.hu domains
  if (!ALLOWED_HOSTS.includes(targetUrl.host.toLowerCase())) {
    return new Response(`Domain not allowed: ${targetUrl.host}`, { status: 403 })
  }

  // Fetch the image from klubradio.hu
  try {
    const response = await fetch(targetUrl.toString())

    if (!response.ok) {
      console.error(`Upstream error: ${response.status} for ${targetUrl}`)
      return new Response(`Upstream error: ${response.status}`, {
        status: response.status,
      })
    }

    const blob = await response.blob()
    const contentType = response.headers.get('Content-Type') || 'image/jpeg'

    return new Response(blob, {
      headers: {
        'Content-Type': contentType,
        'Access-Control-Allow-Origin': '*',
        'Cache-Control': 'public, max-age=31536000', // Cache for 1 year
      },
    })
  } catch (error) {
    console.error('Error fetching image:', error)
    return new Response('Error fetching image', { status: 500 })
  }
})

/* To invoke:

  Production:
  https://arakbotxgwpyyqyxjhhl.supabase.co/functions/v1/image-proxy?url=https://www.klubradio.hu/data/musorkepek/example.jpeg

  Local testing:
  1. Run `supabase start`
  2. Test:
  curl 'http://127.0.0.1:54321/functions/v1/image-proxy?url=https://www.klubradio.hu/data/sound-speaker-radio-microphone_focuspoint_340x340.jpg' --output test.jpg

*/
