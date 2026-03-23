# Web Image Proxy Setup

## Problem

Flutter Web builds run in the browser and are subject to CORS (Cross-Origin Resource Sharing) policies. When loading images from `klubradio.hu`, the browser blocks the requests because the server doesn't send appropriate CORS headers.

## Current Solution

The app uses a **public CORS proxy service** (`corsproxy.io`) that forwards image requests with proper CORS headers.

**Implementation:**
- `lib/utils/web_image_proxy.dart` - Transforms image URLs on web platform
- `lib/screens/widgets/stateless/image_url.dart` - Uses the proxy automatically

**How it works:**
- On mobile/desktop: Direct URLs (no proxy)
- On web: `https://corsproxy.io/?https://www.klubradio.hu/data/...`

## Production Solution (Recommended)

For better reliability, privacy, and control, deploy your own image proxy as a **Supabase Edge Function**.

### 1. Create the Edge Function

```bash
# Install Supabase CLI if not already installed
# https://supabase.com/docs/guides/cli

# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref arakbotxgwpyyqyxjhhl

# Create the function
supabase functions new image-proxy
```

### 2. Implement the Function

Create `supabase/functions/image-proxy/index.ts`:

```typescript
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const ALLOWED_HOSTS = [
  'www.klubradio.hu',
  'klubradio.hu',
  'images.klubradio.hu',
  'cdn.klubradio.hu',
]

serve(async (req) => {
  // Handle CORS preflight
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
    return new Response('Domain not allowed', { status: 403 })
  }

  // Fetch the image
  try {
    const response = await fetch(targetUrl.toString())

    if (!response.ok) {
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
```

### 3. Deploy the Function

```bash
# Deploy to Supabase
supabase functions deploy image-proxy

# Test the function
curl "https://arakbotxgwpyyqyxjhhl.supabase.co/functions/v1/image-proxy?url=https://www.klubradio.hu/data/sound-speaker-radio-microphone_focuspoint_340x340.jpg"
```

### 4. Update the Flutter App

Edit `lib/utils/web_image_proxy.dart`:

```dart
static String _proxyViaSupabase(String originalUrl) {
  const functionUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co/functions/v1/image-proxy';
  return '$functionUrl?url=${Uri.encodeComponent(originalUrl)}';
}
```

Then change line ~32 to use Supabase:

```dart
// Option 1: Use your own Supabase Edge Function (recommended for production)
return _proxyViaSupabase(originalUrl);

// Option 2: Use public CORS proxy (quick solution, not recommended for production)
// return _proxyViaPublicService(originalUrl);
```

### 5. Benefits of Self-Hosted Proxy

✅ **Reliability**: No dependency on third-party services
✅ **Privacy**: Images don't route through external proxies
✅ **Performance**: Supabase Edge Functions run on Cloudflare's global network
✅ **Control**: Configure caching, rate limiting, and access control
✅ **Security**: Domain whitelist prevents abuse

## Alternative: Contact klubradio.hu

The cleanest solution would be for `klubradio.hu` to add CORS headers to their image server:

```
Access-Control-Allow-Origin: *
```

This would eliminate the need for any proxy. Consider reaching out to their technical team.

## Testing

After deploying changes:

```bash
# Build and test web version
flutter build web
cd build/web
python3 -m http.server 8080

# Open http://localhost:8080 and check browser console for CORS errors
```
