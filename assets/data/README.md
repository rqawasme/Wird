# Content schema

All religious content is bundled as JSON in this directory and parsed once at app startup. The app never writes here — these files are the immutable source of truth shipped with each release.

## Files

- `adhkar.json` — array of `Dhikr` objects. The pool of individual acts of remembrance, keyed by `id`. Wirds and collections reference these ids.
- `wirds.json` — array of `Wird` objects. Classical wird sources the user can subscribe to.
- `collections.json` — array of `Collection` objects. Emotion- or context-tagged dua packs.

## Dhikr

```json
{
  "id": "string — stable unique key, snake_case, e.g. \"subhanallah_33\"",
  "title": "string — short label, e.g. \"Tasbih\"",
  "arabic": "string — Arabic text with diacritics",
  "translation": "string — English meaning",
  "transliteration": "string — simplified transliteration, e.g. \"SubḥānAllāh\"",
  "virtues": "string — narrative explanation of the merits of this dhikr",
  "count": "int — default repetition count; can be overridden inside a wird/collection step",
  "source": "string — hadith or Qur'an citation, e.g. \"Bukhari 6310\"",
  "tags": ["string", "..."],
  "repeatGroup": "string | null — adhkar sharing the same repeatGroup are presented as one tap-through (e.g. the three Quls)"
}
```

### Tags

Free-form, but the app currently recognizes the following: `morning`, `evening`, `after_salah`, `before_sleep`, `anxiety`, `grief`. New tags can be added freely; they will only matter once filtering or search is added.

### Repeat groups

If multiple adhkar share the same `repeatGroup` string, the player renders them stacked as a single step. The shared counter uses the maximum `count` of any group member. The classic example is the three Quls (`al_ikhlas`, `al_falaq`, `an_nas`), all assigned `repeatGroup: "three_quls"`.

## Wird

```json
{
  "id": "string — stable unique key",
  "title": "string — display title, preferably the classical Arabic name in transliteration",
  "subtitle": "string — one-line English description",
  "cover": "string — asset path for a cover image, e.g. \"assets/covers/hisn_morning.jpg\"",
  "author": "string — compiler or attribution",
  "createdAt": "string — free-form provenance text",
  "durationMinutes": "int — rough estimated duration",
  "steps": [
    {
      "dhikrId": "string — references an id in adhkar.json",
      "countOverride": "int | null — overrides Dhikr.count when present"
    }
  ]
}
```

## Collection

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "tags": ["string", "..."],
  "period": "morning | evening | beforeSleep | afterSalah | anytime | null",
  "durationMinutes": "int",
  "steps": [ /* same shape as Wird.steps */ ]
}
```

The `period` is a hint shown to the user when subscribing — it does not yet drive scheduling in v1.

## Authoring rules

- **Every `dhikrId` referenced in a Wird or Collection must exist in `adhkar.json`.** The app will throw a clear error at startup otherwise.
- **Use one canonical Dhikr entry per remembrance.** Wirds reference it by id; counts can vary per occurrence via `countOverride`. Do not duplicate adhkar across files.
- **Arabic text** should include short vowel marks (taḥrīk) and be free of pointing errors. Prefer the script as it appears in canonical hadith editions.
- **Transliteration** uses Brill / ALA-LC conventions where reasonable. Keep it readable; this is not a scholarly edition.
- **Sources** should cite the standard reference: collection name + hadith number, or Qur'an surah:ayah.

## Validation tip

Before publishing a new release, run the app's debug-only content-validation pass (logs to console on first launch in debug builds) to confirm every step's `dhikrId` resolves.
