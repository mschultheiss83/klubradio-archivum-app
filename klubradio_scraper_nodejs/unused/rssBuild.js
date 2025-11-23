const RSS = require('rss');
const logger = require('../loggingSetup');

function buildRssFeed(shows, title, description, link, klubradio_link) {
  logger.info('Starte die RSS-Feed-Erstellung...');

  const feed = new RSS({
    title: title,
    description: description,
    feed_url: link,
    site_url: link,
    language: 'hu-hu',
    pubDate: new Date().toUTCString(),
    // Hinzufügen der Namespaces für iTunes, Spotify und Google Play
    custom_namespaces: {
      'itunes': 'http://www.itunes.com/DTDs/Podcast-1.0.dtd',
      'googleplay': 'http://www.google.com/schemas/play-podcasts/1.0',
      'spotify': 'http://www.spotify.com/ns/rss'
    },
    custom_elements: [
      {'itunes:author': 'Klubrádió Archiv'},
      {'itunes:image': {
          _attr: {
            href: `${klubradio_link}/static/frontend/imgs/KR-clean-logo.png`
          }
        }},
      {'itunes:explicit': 'no'},
      {'itunes:owner': [
          {'itunes:name': 'Klubrádió Archiv'},
          {'itunes:email': 'kontakt@klubradio.hu'} // Beispiel
        ]},
      // Spotify-spezifische Tags
      {'spotify:limit': {
          _attr: {
            'recentCount': 50 // Begrenze den Feed auf die letzten 50 Episoden
          }
        }}
    ]
  });

  for (const show of shows) {
    if (show.audio_url) {
      feed.item({
        title: show.title || 'Unbekannter Titel',
        description: show.description || '',
        url: show.audio_url,
        guid: show.audio_url, // GUID für eindeutige Erkennung
        enclosure: {
          url: show.audio_url,
          size: show.file_size || 0, // Dateigröße, falls verfügbar
          type: 'audio/mpeg'
        },
        date: show.date ? new Date(show.date).toUTCString() : new Date().toUTCString(),
        custom_elements: [
          // Gemeinsame Tags für iTunes und Spotify
          {'itunes:duration': show.duration},
          {'itunes:explicit': 'no'},
          {'itunes:summary': show.description || ''},
          // Google Play Tag (falls benötigt)
          {'googleplay:description': show.description || ''},
          {'googleplay:image': {
              _attr: {
                href: `${link}/podcast_logo.png`
              }
            }}
        ]
      });
    }
  }

  const xmlString = feed.xml({ indent: true });
  logger.info('RSS-Feed-Erstellung abgeschlossen.');
  return xmlString;
}

module.exports = {
  buildRssFeed,
};