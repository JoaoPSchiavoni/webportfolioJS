{{flutter_js}}
{{flutter_build_config}}

async function clearLegacyFlutterCache() {
  if ('serviceWorker' in navigator) {
    const registrations = await navigator.serviceWorker.getRegistrations();
    await Promise.all(
      registrations.map((registration) => registration.unregister()),
    );
  }

  if ('caches' in window) {
    const cacheNames = await caches.keys();
    await Promise.all(
      cacheNames
        .filter((name) => name.startsWith('flutter-'))
        .map((name) => caches.delete(name)),
    );
  }
}

clearLegacyFlutterCache()
  .catch((error) => console.warn('Unable to clear the legacy cache.', error))
  .finally(() => _flutter.loader.load());
