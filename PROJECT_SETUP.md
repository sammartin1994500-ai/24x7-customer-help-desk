# Project setup and current limitations

## What is included

This package contains the complete source tree from the uploaded ZIP: the React/Vite wedding invitation, admin studio UI, invitation defaults, RSVP UI, photo-management UI, shared components, and the Base44 entity/config files that were present in the upload.

## Run the frontend

Requirements: Node.js 20.19+ (or 22.12+) and npm.

```bash
npm install
npm run dev
```

Open the local URL printed by Vite. To create a production frontend bundle:

```bash
npm run build
npm run preview
```

The Vite configuration has been repaired for standalone frontend development and the `@` source alias.

## Important: backend is not configured in the supplied source

The project now includes a local-preview fallback database so the invitation can render without a Base44 connection. This fallback is intentionally non-persistent: it does not save RSVP records, authenticate users, or upload photographs. The uploaded source contains fallback/no-op database clients in several files, including `src/api/base44Client.js`, `src/lib/AuthContext.jsx`, `src/hooks/useInvitationData.js`, and the admin components. These fallback clients return empty data and do not save records, authenticate users, upload photographs, or persist RSVP submissions.

The app code calls Base44 entities named `Invitation` and `CouplePhoto`, but the uploaded `base44/entities/` folder contains only `Rsvp.jsonc` and `User.jsonc`. Therefore the uploaded files alone do not provide the complete backend schema or a configured Base44 app connection.

For the full admin, photo upload, authentication, live updates, and persistent RSVP functionality, connect this frontend to the original Base44 app and provide its real SDK client/backend configuration. Create or restore the `Invitation` and `CouplePhoto` entities with permissions appropriate to the app. Do not expose admin credentials or private API keys in frontend code.

## Wedding content defaults

The invitation defaults are in `src/lib/invitationDefaults.js`. They include the couple names, event dates, venue, family details, schedule, and invitation text. Review these details before publishing.

## Verification status

This package is a source-code handoff, not a verified production deployment. Dependencies were not installed in this environment, so a fresh `npm install` and `npm run build` have not been run here. Backend-dependent features cannot be verified from the uploaded archive alone.
