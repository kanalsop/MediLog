---
name: MediLog
colors:
  surface: '#f5fced'
  surface-dim: '#d6dcce'
  surface-bright: '#f5fced'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f6e7'
  surface-container: '#eaf0e1'
  surface-container-high: '#e4eadc'
  surface-container-highest: '#dee5d6'
  on-surface: '#171d14'
  on-surface-variant: '#3f4a3a'
  inverse-surface: '#2c3228'
  inverse-on-surface: '#edf3e4'
  outline: '#6f7a68'
  outline-variant: '#bfcab5'
  surface-tint: '#3A9C23'
  primary: '#3A9C23'
  on-primary: '#ffffff'
  primary-container: '#228709'
  on-primary-container: '#f8ffef'
  inverse-primary: '#79dd5d'
  secondary: '#C9543E'
  on-secondary: '#ffffff'
  secondary-container: '#ff7c63'
  on-secondary-container: '#721506'
  tertiary: '#a7256d'
  on-tertiary: '#ffffff'
  tertiary-container: '#c74087'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#94fa76'
  primary-fixed-dim: '#79dd5d'
  on-primary-fixed: '#032100'
  on-primary-fixed-variant: '#0d5300'
  secondary-fixed: '#ffdad3'
  secondary-fixed-dim: '#ffb4a5'
  on-secondary-fixed: '#3f0400'
  on-secondary-fixed-variant: '#852312'
  tertiary-fixed: '#ffd8e6'
  tertiary-fixed-dim: '#ffb0d0'
  on-tertiary-fixed: '#3d0024'
  on-tertiary-fixed-variant: '#8b0357'
  background: '#f5fced'
  on-background: '#171d14'
  surface-variant: '#dee5d6'
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

The design system is centered on clarity, reliability, and accessibility. It targets individuals managing their daily health routines, requiring an interface that feels both "clinical" (trustworthy and precise) and "friendly" (approachable and encouraging).

The visual style is **Corporate / Modern**, strictly adhering to Apple’s Human Interface Guidelines. It leverages a clean, flat aesthetic that prioritizes content over decoration. High-legibility typography and generous whitespace reduce cognitive load, while the vibrant primary green evokes health and vitality. The interface uses subtle depth and large interactive surfaces to ensure ease of use for all age groups, including those with limited dexterity.

## Colors

This design system utilizes a palette rooted in healthcare semiotics.

- **Primary Green (#3A9C23):** Used for primary actions, success states, and indicating completed medication adherence. It serves as the visual anchor for the app.
- **Secondary Red (#C9543E):** Reserved for alerts, explicitly skipped doses, and destructive actions. It is a "soft" red to maintain the friendly tone without causing unnecessary anxiety.
- **Backgrounds:** A tiered system of soft whites (`#FFFFFF`) for cards and input fields, set against a very light gray background (`#F9FAFB`) to create subtle contrast and structural hierarchy.
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

- **Level 0 (Background):** Soft light gray (`#F9FAFB`).
- **Level 1 (Cards/Containers):** Pure white (`#FFFFFF`) with a subtle 1px border in a very light gray.
- **Active State:** When a card or button is pressed, a very soft, diffused ambient shadow (4px blur, 10% opacity) may be applied to indicate the interaction.
- **Modals:** Use standard iOS sheet presentation with a backdrop dimming effect to focus the user on the task at hand (e.g., adding a new medication).

## Shapes

The shape language is consistently **Rounded**, reflecting the "friendly" side of the brand.

- **Primary Containers:** Cards and large action buttons use a 16px (1rem) corner radius.
- **Inner Elements:** Input fields and small pill-style tags use an 8px (0.5rem) radius to maintain a nested visual harmony.
- **Icons:** Use the SF Symbols "hierarchical" or "multicolor" style with rounded terminals to match the UI's softness.

## Components

### Buttons

- **Primary:** Filled with Primary Green, white text, 17px Semi-Bold.
- **Secondary:** White background with a Primary Green border and text.
- **Large Touch Targets:** All buttons have a minimum height of 50px for critical actions like "Save" or "Mark as Taken."

### Cards

Medication cards are the primary interface element. They feature a white surface, rounded corners, and a left-aligned vertical "status strip" (Green for taken, Red for skipped, Gray for pending).

### Status Indicators

- **Checkmarks:** Used inside a circular container (24x24px) for completed tasks.
- **Crosses/Alerts:** Used for skipped medications or destructive actions, paired with the secondary red color.

### Navigation Bar & Tab Bar

- **Navigation Bar:** Follows iOS Large Title patterns, transitioning to an inline title on scroll.
- **Tab Bar:** Clear, recognizable icons for "Records," "Calendar," and "Medications," using Primary Green for the active state and Medium Gray for inactive.

### Input Fields

Forms (like "Add Medication") use "Inset Grouped" style list rows with clear labels and placeholder text that disappears on focus.
