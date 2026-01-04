# Play Console Account Setup (Issue #59)

## Quick Status
- Needed: Google Play developer account (one-time $25 fee)
- Owner: (external) — requires human identity verification
- Target: finish signup + verification (1–2 days)

## Prereqs to Have Ready
- Google account to own the developer profile
- Payment method for $25 USD fee
- Government ID for identity verification
- Business info (if applicable): legal name, address, phone
- Support email you want visible in the store (can change later)

## Signup Steps
1) Go to https://play.google.com/console/signup and log in with the chosen Google account.
2) Pay the $25 registration fee (one-time).
3) Complete identity verification (upload ID, selfie, or as prompted).
4) Fill developer profile details (name, contact email, phone, address).
5) Enable 2‑step verification on the account (required).

## Post-Approval Steps (do after account is active)
- Add additional users/roles if needed.
- Set the public support email you want users to see.
- Create the app entry when ready (Phase 2/3).
- Turn on Play App Signing; keep the upload keystore safe:
  - Current upload key: `/Volumes/2TB/code/.android-signing/klubradio-upload-keystore.jks`
  - SHA1: `4C:FA:F2:6F:E1:B0:6F:04:08:7A:7A:85:9B:2A:7D:2F:8C:46:FF:3C`
- Keep `key.properties` out of git (already ignored).

## What to Report Back to Close #59
- Confirmation that signup + $25 payment succeeded.
- Identity verification approved.
- Developer profile completed (name/email/phone/address).
- 2‑step verification enabled.
- Account ready to create the app entry.
