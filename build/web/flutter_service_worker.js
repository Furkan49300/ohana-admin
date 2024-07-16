'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "45c9eb7fa6e6a781268f8a3b8d62d8b9",
".git/config": "4bb36155a93c3700689659b977c93401",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "36fdc21d13ac396886ceb904b5f2aed0",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "4894b31bcde706a766023ae4c0a7ae70",
".git/logs/refs/heads/main": "554ff4727983909ed017d50ff9923fe2",
".git/logs/refs/remotes/origin/main": "48c64cb65981575459c1941658bd7737",
".git/objects/00/84943c80858dd1060e467615c392b5e5f7a5bb": "48d2b5ae68448358d54e3be04bf7430d",
".git/objects/05/b426146391e18fac5086a106124fb25bbe2ebe": "d577955b05fb62dab8c720ac01ecc74c",
".git/objects/06/5a156ad876ae75d08bca0aabc8c1e01f285abb": "1338ac20d12542d14345378e2fe2be26",
".git/objects/07/74c17c0fa7a7e87e24a6935830998d92b52c75": "cd62ee54b7ceea7b2a7804e69b1d9134",
".git/objects/0e/d2ccaf93f8fbe9740bdb7cc6c4bf61cf47a759": "40bf5f8d82451450359649f9fa8828f4",
".git/objects/10/f9e2471f90a5fa6cd405f5e63485300770f022": "9006b031127d694e2d67bca1868ebfcb",
".git/objects/15/396c1359f13a72f51ddb0cdf7f0aee521bf72d": "882987fc7eaba675f39bcb82031041e8",
".git/objects/16/5ce0ddf03a820a38f48cba9aa0c9df9b6e6b79": "71df17c95c3124eada62b59e7dabda78",
".git/objects/1b/789ca26a00350a2421507320dde3594d9bf311": "d68c067207470399c0040b81d7c0e984",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/29/6f4aa2e3bdac50c21a06f3d5f0793897b4a070": "b67277a5d56b2a2bf567e25bf2b02f78",
".git/objects/2a/48f33346e302ef5b17b5c27ba9808aaa2e9cf5": "2b9f8e039a0d340292cca30ec3e22195",
".git/objects/2b/58d7146b5f0dc5cb4459800d0d56f7a908c7c6": "63b6c46287ed9668b24d7b48d443ec9b",
".git/objects/2d/0471ef9f12c9641643e7de6ebf25c440812b41": "d92fd35a211d5e9c566342a07818e99e",
".git/objects/32/5e6324891a53d35767ff695b5c0a86d38dc4fa": "6ed62dc6c91233cd1891c9f903990fce",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/3b/b0860a0981211a1ab11fced3e6dad7e9bc1834": "3f00fdcdb1bb283f5ce8fd548f00af7b",
".git/objects/3f/93959ffdea8eddbccc6f622f8608dd0a0f6768": "f48e2e4a609e4b465476df208ee85f1c",
".git/objects/45/0c834e3d79ad5f9e1470777bb9609f8a3109b2": "f02598acc7fcaf59e92307c4a5d5d6ec",
".git/objects/45/61b86a1e8f2aef17fffaa1763121bc45f9a231": "244861d6e31c9c16c0ffc6e580893aea",
".git/objects/49/5b9a1eeb14627d60e5c92249062cc3bdc0dd4d": "e61e8a4af1044c14f9c2317361d850fb",
".git/objects/4a/39079e580dc9be820cba2fae41238c49eaa798": "ada1a19fea32fbb6719120809b9eae60",
".git/objects/4b/b92f7130c4723a46fef45e47e5f8fad762b173": "02940e52bbd8252b404681d4a17286f8",
".git/objects/5a/7b05e1be311772247124911182fda78fde2cec": "d38bfbb93663df272dc4920186bd1040",
".git/objects/5d/7a920539aa456f4401ebad5adf164f7aaabc36": "8b3fad484db344f140403f9f007beb4d",
".git/objects/5f/21374c1fa2cd660e6abccfd4cbb08318bece38": "0b45716144cf0cc6c80912f1d31d581f",
".git/objects/68/231c664947f806bde3b98d533fa690f71ea8e9": "1ea21839c877ee10bdfe41cf82323a8c",
".git/objects/69/0ad8b32747252e1e4baec83618e50a7150415d": "610a2e22922876194219c606686caeb4",
".git/objects/6a/8079958813cc4ce103f6f78a753c763a1ae08a": "705b7aef5b71f27b3d40b0f46d032e83",
".git/objects/6d/b4bd71271f559a9d635f3ad097e4ba991a35b2": "04dc4f593934f8f954c3b7519f3fc1f4",
".git/objects/6f/9cad4c116bc8d72e2497226abb5c05ee64982c": "0d104480d68c1652a53721377a02a882",
".git/objects/71/5501a7324a081acbe3d3224bee295b2e4412d6": "adf25cbdab0000ee9da3b8e4d54dad94",
".git/objects/71/7117947090611c3967f8681ab1ac0f79bca7fc": "ad4e74c0da46020e04043b5cf7f91098",
".git/objects/71/7809363ed19bdd7e1d78f6e421e40a96bc29e3": "9414a3044cb191cc3f57340f57c3dc93",
".git/objects/71/e3c75f3fdf12bb83b0ad675acc73c1205a1ee0": "3b8cf2f2ebb655a0ba663f89254b020f",
".git/objects/77/d248bde08bd162807f5633d4cfe9528ae97102": "9a09f55860b331d5ebc043af299ced5b",
".git/objects/7e/298cb0c0047e01c6bf31f9ed087cfd51b368c3": "f2148c8dd025763c074e9c1cb23efa6f",
".git/objects/80/5134f32d5123482087ccb56cfc81d30eec8288": "2d3f5d7bc48b921a317756f9ad8a70d6",
".git/objects/87/7a11dd260b5a86d243fbec458439a2aeec1270": "282cd3324a6ca9af2280a44f732ff8b3",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8f/5919035dc2d545052259e960c44ed79165ef51": "6ce9851767b7533d9b7fcba0833dee72",
".git/objects/91/1d4c747347178a6501441e71538e6a0754766e": "fbbe7cede0f826414509926ae6353486",
".git/objects/94/bfb1463ad8331bfd687bc751b8920b133da744": "fd2d8c0d844b234856b36b93f652048f",
".git/objects/99/9a89180478519b22af700a5f568be8123eb9c3": "17991429a9a9505275f551ba15703cb9",
".git/objects/9f/8062a713c4af5045e82ba34633d7f66d453c73": "e10ac3156a3c3788518175c752fcc806",
".git/objects/a3/7da881712104020b60d56a7524993a505ff877": "377891ada1daac34d1c3c516c9df0ca3",
".git/objects/af/742adee0a85dd21ea96cbd84182e30e085d6cf": "aa25b932ec40efacb1efe27e7cf25d82",
".git/objects/b2/f68cf15c2a5650aa3c8fd4f7b216dccca83332": "72e627fc52eb2ff4d245109845857351",
".git/objects/b5/0254288cc6319d153c4af1d64870d95ee2436f": "468a6506934a07c970a4739eae75eedd",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bf/2c9f910df7f74d72fa996de39517e8652080c1": "4f02c3d5e74e4c8bc38939a7a62f7448",
".git/objects/c0/13b1abb6c8418a9d805a0e3408579be541f257": "155f69623a31e47ed8f1c1ceb1a01b15",
".git/objects/c5/f4bc2a4da91586f3005813077f0d0aa9040f82": "3191028b787554cee4652f5050144bff",
".git/objects/c6/ce3a6ef3dc149c88ca7748565dcbb2a8465dd9": "261eaebab1d340f06d6b64d3a75897a2",
".git/objects/c7/7663172ca915a99a594ca17d06f527db05657d": "6335b074b18eb4ebe51f3a2c609a6ecc",
".git/objects/cc/55905ffe185d5cbf5246e0953388f3199e8eb7": "a24e687cfd1cbbc7998841a67eda5252",
".git/objects/cc/fe63e9b8e8d6488ff8ca9e15fa0544845c6573": "16a974e2e50a386de91faaafbc5e94e5",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/e8/2c5850db3a3482d0c954a4dc122c02de555ce7": "d357cd906b3805bf81477f5527cca086",
".git/objects/ea/1b531737ef5e6bc9b8bbcf03a5a37d4106e1f8": "a4f1c1fd9bfe5e54b5fd64e816127815",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f7/12d69b1a892a0769cd5cdc5baddf3f77885b19": "b98e2b649db982b4b7e5fa1e5fe9e341",
".git/objects/ff/2fac8a4d1f59bb666af8ca54c54a24faca89b7": "3a2c500b4b0e53f825eec8ea125755a8",
".git/refs/heads/main": "887ff27136f92000495874d2ee236bb3",
".git/refs/remotes/origin/main": "887ff27136f92000495874d2ee236bb3",
"assets/AssetManifest.bin": "0d8c2d11ac4558477d9931ef85341c86",
"assets/AssetManifest.bin.json": "9174c942ebbb5dd7a7e62ff04c8f5f53",
"assets/AssetManifest.json": "14f3e77517d0e94377b35ba5ecd7269a",
"assets/assets/images/article-image-petit.jpg": "cbcfaf43d035badfde3c29549770d5e2",
"assets/assets/images/article-image.jpg": "19dfcad5e0a741fc543e3b3aaffa7e7f",
"assets/assets/images/bureaux.jpg": "78bf973b92ad6015b44004aae3e3c055",
"assets/assets/images/bureauxpetit.jpg": "6e502d9973c52fd259db004a889c3ea9",
"assets/assets/images/logo.png": "17510e239b23fb87564f9e6af3c5257d",
"assets/assets/images/logo2.png": "c7a78260095628b48a719e8454191ba0",
"assets/assets/images/presta.png": "5db0a8818f82d2a0ac4e353bd927356b",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "59ef4c4529b11bfc3855ef63ae905615",
"assets/NOTICES": "4aece26fd489402e45734c4be37065f9",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/quill_html_editor/assets/camera_roll_icon.png": "962f1d57cab7451d4b92b236b1993bd5",
"assets/packages/quill_html_editor/assets/delete_column.png": "62358bf5aa9ac7f18e2411e4a0c63f14",
"assets/packages/quill_html_editor/assets/delete_row.png": "3a56332918794e49ffca20016948553d",
"assets/packages/quill_html_editor/assets/delete_table.png": "37e148071ce0a306a27f296369e52f40",
"assets/packages/quill_html_editor/assets/edit_table.png": "6a51397f56e90d98ae0b46a2e359676f",
"assets/packages/quill_html_editor/assets/h1_dark.png": "aa135c261ba758a3990d4594d982104d",
"assets/packages/quill_html_editor/assets/h2_dark.png": "037de75dfed94244b78e7493c6425586",
"assets/packages/quill_html_editor/assets/insert_column_left.png": "114e6cca4b2f60a5eaebe4e574f2c36d",
"assets/packages/quill_html_editor/assets/insert_column_right.png": "fb27c4e3cc557089f79dd1f0cc937d62",
"assets/packages/quill_html_editor/assets/insert_row_above.png": "80ae3856d5f7415d9957d9a1699ec782",
"assets/packages/quill_html_editor/assets/insert_row_below.png": "cea46607b37038f71c0fec22341b80e4",
"assets/packages/quill_html_editor/assets/insert_table.png": "c8f041a07bc6b8e4010ccf93ba4c291d",
"assets/packages/quill_html_editor/assets/scripts/quill_2.0.0_4_min.js": "3f4b931496920ee12125e575f1c15dfa",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "7684d2722566bd466e81a0a8b24d063a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5c7f58421f7f6cfae9d36acac73b2b7a",
"/": "5c7f58421f7f6cfae9d36acac73b2b7a",
"main.dart.js": "360acd4966d3856c395dc980d09f67e3",
"manifest.json": "b94cd9b45de121fa7fd8c2c2aab38c3f",
"version.json": "a0da6a9e2053b2ad445b0d0033e47996"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
