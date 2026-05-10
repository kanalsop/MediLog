---
name: MediLog
colors:
  surface: '#f7fffe'
  surface-dim: '#d3f2f0'
  surface-bright: '#f7fffe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#e7fffd'
  surface-container: '#d9fbf9'
  surface-container-high: '#c9f4f2'
  surface-container-highest: '#b8e9e7'
  on-surface: '#07282a'
  on-surface-variant: '#3e595b'
  inverse-surface: '#20383a'
  inverse-on-surface: '#ecfffe'
  outline: '#4f7f81'
  outline-variant: '#99dad8'
  surface-tint: '#70FCF8'
  primary: '#70FCF8'
  primary-strong: '#007C7A'
  on-primary: '#063d40'
  primary-container: '#d8fffe'
  on-primary-container: '#073032'
  inverse-primary: '#007c7a'
  secondary: '#FCC4BE'
  secondary-strong: '#A33A48'
  on-secondary: '#4a1714'
  secondary-container: '#ffe4e0'
  on-secondary-container: '#4a1714'
  tertiary: '#ffb7b2'
  on-tertiary: '#4a1714'
  tertiary-container: '#ffdeda'
  on-tertiary-container: '#4a1714'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#b8fffd'
  primary-fixed-dim: '#70FCF8'
  on-primary-fixed: '#063d40'
  on-primary-fixed-variant: '#0b5a5e'
  secondary-fixed: '#ffe4e0'
  secondary-fixed-dim: '#FCC4BE'
  on-secondary-fixed: '#4a1714'
  on-secondary-fixed-variant: '#7b2532'
  tertiary-fixed: '#ffd8e6'
  tertiary-fixed-dim: '#ffb0d0'
  on-tertiary-fixed: '#3d0024'
  on-tertiary-fixed-variant: '#8b0357'
  background: '#f7fffe'
  on-background: '#07282a'
  surface-variant: '#d9fbf9'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 34px
    fontWeight: '700'
    lineHeight: 41px
    letterSpacing: 0.37px
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: 0.35px
  body-lg:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: -0.41px
  body-sm:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: -0.24px
  label-bold:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: -0.08px
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 13px
    letterSpacing: 0.06px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-main: 1.25rem
  gutter-grid: 1rem
  stack-gap-lg: 1.5rem
  stack-gap-md: 1rem
  stack-gap-sm: 0.5rem
---

## Brand & Style

The design system is centered on clarity, reliability, accessibility, and a soft sense of companionship. It targets individuals managing their daily health routines, requiring an interface that feels trustworthy, easy to read, and gently cute.

The visual style is **Friendly / Modern**, strictly adhering to Apple’s Human Interface Guidelines. It leverages a clean, flat aesthetic that prioritizes content over decoration. High-legibility typography and generous whitespace reduce cognitive load, while a cat mascot adds warmth without interfering with medication records. The interface uses subtle depth and large interactive surfaces to ensure ease of use for all age groups, including those with limited dexterity.

## Colors

This design system uses a light cyan and soft pink palette to make daily medication tracking feel approachable while keeping strong contrast for text and controls.

- **Primary Cyan (#70FCF8):** Used for friendly highlight surfaces and selected backgrounds. Because the color is bright, text placed directly on it must use dark teal (`#063D40`) rather than white.
- **Primary Strong Teal (#007C7A):** Used for active tabs, icons, outlines, links, and status indicators on white surfaces where `#70FCF8` would not have enough contrast.
- **Secondary Pink (#FCC4BE):** Used for soft secondary accents and small mascot details.
- **Secondary Strong Rose (#A33A48):** Used for skipped-dose indicators and pink-related text/icons where readable contrast is required.
- **Cat Mascot Colors:** Soft cream fur (`#FFF4DA`) and warm blush (`#FFB7B2`) are used only for the character, keeping the main UI calm.
- **Backgrounds:** A tiered system of soft whites (`#FFFFFF`) for cards and input fields, set against a very light cyan background (`#F7FFFE`) to create subtle contrast and structural hierarchy.
- **Neutrals:** Standard iOS-aligned grays are used for secondary text and borders to maintain a native look and feel.

## Typography

The typography system uses **Inter** (as the closest high-quality alternative to San Francisco) to provide a native iOS experience. It prioritizes a clear information hierarchy:

- **Headlines:** Use Bold weights for screen titles and medication names to ensure they are the first thing a user sees.
- **Body Text:** Standardized at 17px for optimal readability on mobile devices, following HIG standards for "Body" text.
- **Labels:** Used for timestamps and dosage instructions, ensuring small text remains legible through medium weights and slightly increased tracking.

## Layout & Spacing

The design system follows a **fluid grid** model optimized for handheld devices.

- **Margins:** A consistent 20px (1.25rem) horizontal margin is maintained across all screens to prevent content from touching the edges of the display.
- **Stacking:** Elements within cards (like medication name vs. time) use an 8px (0.5rem) gap, while separate cards in a list use a 16px (1rem) vertical gap.
- **Touch Targets:** All interactive elements maintain a minimum height of 44px to ensure accessibility for users with varying levels of motor control.

## Elevation & Depth

This design system avoids heavy shadows, opting instead for **tonal layers** and **low-contrast outlines**.

- **Level 0 (Background):** Very light cyan (`#F7FFFE`).
- **Level 1 (Cards/Containers):** Pure white (`#FFFFFF`) with a subtle 1px border in cyan-gray.
- **Active State:** When a card or button is pressed, a very soft, diffused ambient shadow (4px blur, 10% opacity) may be applied to indicate the interaction.
- **Modals:** Use standard iOS sheet presentation with a backdrop dimming effect to focus the user on the task at hand (e.g., adding a new medication).

## Shapes

The shape language is consistently **Rounded**, reflecting the "friendly" side of the brand.

- **Primary Containers:** Cards and large action buttons use a 16px (1rem) corner radius.
- **Inner Elements:** Input fields and small pill-style tags use an 8px (0.5rem) radius to maintain a nested visual harmony.
- **Icons:** Use the SF Symbols "hierarchical" or "multicolor" style with rounded terminals to match the UI's softness.

## Components

### Buttons

- **Primary:** Filled with Primary Strong Teal and white text, 17px Semi-Bold. For softer selected surfaces, use Primary Cyan with dark teal text.
- **Secondary:** White background with a Primary Strong Teal border and text.
- **Large Touch Targets:** All buttons have a minimum height of 50px for critical actions like "Save" or "Mark as Taken."

### Cards

Medication cards are the primary interface element. They feature a white surface, rounded corners, and a left-aligned vertical "status strip" (Strong Teal for taken, Strong Rose for skipped, Gray for pending).

### Mascot

The cat character uses the `assets/pillneko/` image set as the visual mascot. It acts as a gentle guide in empty states and short encouragement panels. The mascot should be decorative and supportive, not a substitute for labels or critical medication information. It should not appear inside every medication card, because repeated decorative elements would reduce scanability.

### Status Indicators

- **Checkmarks:** Used inside a circular container (24x24px) for completed tasks.
- **Crosses/Alerts:** Used for skipped medications or destructive actions, paired with the secondary strong rose color or system destructive styling when the action is irreversible.

### Navigation Bar & Tab Bar

- **Navigation Bar:** Follows iOS Large Title patterns, transitioning to an inline title on scroll.
- **Tab Bar:** Clear, recognizable icons for "Records," "Calendar," and "Medications," using Primary Strong Teal for the active state and Medium Gray for inactive.

### Input Fields

Forms (like "Add Medication") use "Inset Grouped" style list rows with clear labels and placeholder text that disappears on focus.
