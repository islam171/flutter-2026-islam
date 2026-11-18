# Practice 11 - NOTES

> Level 1 values below are what jsonplaceholder is documented/known to return.
> Re-run the curl commands yourself and fix anything that differs.

```
curl -i https://jsonplaceholder.typicode.com/users
curl -i https://jsonplaceholder.typicode.com/users/1
curl -i https://jsonplaceholder.typicode.com/users/999
curl -i -X POST https://jsonplaceholder.typicode.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","username":"tester","email":"t@example.com"}'
curl -i "https://jsonplaceholder.typicode.com/users?id=3"
```

## GET /users
- Status: 200, `Content-Type: application/json; charset=utf-8`
- Body: a JSON **array** of **10** users (no envelope / `data` key)

## GET /users/1
- Status: 200, body is a single **object**

### User
| field    | JSON type | Dart type  | nullable? |
|----------|-----------|------------|-----------|
| id       | number    | int        | no        |
| name     | string    | String     | no        |
| username | string    | String     | no        |
| email    | string    | String     | no        |
| phone    | string    | String     | no (raw string; `phoneDigits` getter) |
| website  | string    | String?    | yes (only field treated as optional)  |
| address  | object    | Address    | no        |
| company  | object    | Company record `({String name, String catchPhrase})` | no |

### address (nested once)
| field   | JSON type | Dart type | nullable? |
|---------|-----------|-----------|-----------|
| street  | string    | String    | no        |
| suite   | string    | String    | no        |
| city    | string    | String    | no        |
| zipcode | string    | String    | no        |
| geo     | object    | Geo       | no        |

### address.geo (nested twice)
| field | JSON type | Dart type | nullable? |
|-------|-----------|-----------|-----------|
| lat   | **string** ("-37.3159") | double (`double.parse`) | no |
| lng   | **string** ("81.1496")  | double (`double.parse`) | no |

### company
| field       | JSON type | Dart type | nullable? |
|-------------|-----------|-----------|-----------|
| name        | string    | String    | no        |
| catchPhrase | string    | String    | no        |
| bs          | string    | not modelled (ignored) | - |

The server never omits a field in practice. "Nullable" above is *my* decision:
I only defend `website` as optional; every other field being absent is a bug,
and `fromJson` should throw (-> `BadResponseException`).

## GET /users/999
- Status: **404**, body: `{}`  -> `NotFoundException`
- Lesson: `{}` decodes fine, so without `_check` the failure surfaces later in
  `fromJson` as a misleading `BadResponseException`. Status before body.

## POST /users (JSON body + `Content-Type: application/json`)
- Status: **201 Created** (anything else -> `BadResponseException`)
- The server echoes the fields I sent and **adds `id: 11`**
- Nothing is persisted: a later `GET /users` still returns 10

## GET /users?id=3
- Status 200, body is an **array of one** user, not an object
- Via `Uri.https(host, '/users', {'id': '3'})`

## Status -> exception map
| status / event            | exception                 |
|---------------------------|---------------------------|
| SocketException / timeout | NoConnectionException     |
| 401                       | UnauthorizedException     |
| 404                       | NotFoundException         |
| >= 500                    | ServerException(status)   |
| other non-2xx, non-JSON, failed cast | BadResponseException |

## Level 5 timings (fill in)
| scenario                         | time until Offline view |
|----------------------------------|-------------------------|
| Airplane mode, pull to refresh   | ___ s (expect < 1 s)    |
| Wi-Fi with no internet (hotspot) | ___ s (expect ~10 s)    |

## Screenshots to add to the repo root
- `screenshot_timeout.png` - DevTools > Network, `/users` row, no status, ~10 000 ms
- `screenshot_200.png` - DevTools > Network, a 200 row with the response body open
