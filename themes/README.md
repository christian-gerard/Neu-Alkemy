# Neu-Alkemy Theme System

The Neu-Alkemy theme provides a cohesive visual experience across all dotfiles packages, based on a custom color palette with gothic/mystical aesthetics and purple-dominant accents.

## Overview

The theme system is built on a **single source of truth** color palette that ensures consistency across all tools and applications. It extends the Catppuccin color philosophy with custom Neu-Alkemy colors for a unique, cohesive experience.

## Theme Structure

```
themes/
└── neu-alkemy/
    ├── palette.toml          # Master color definitions
    ├── variants/             # Theme variants
    │   ├── dark.toml        # Dark variant (default)
    │   ├── light.toml       # Light variant
    │   └── midnight.toml    # Ultra-dark variant
    └── apps/                # Application-specific themes
        ├── aerospace/       # AeroSpace window manager
        ├── ghostty/         # Terminal emulator
        ├── nvim/           # Neovim editor
        ├── starship/       # Shell prompt
        └── tmux/           # Terminal multiplexer
```

## Color Palette

The Neu-Alkemy palette is defined in `palette.toml` and consists of several color categories:

### Base Colors
```toml
[base]
rosewater = "#E8D5D0"  # Warm neutral
flamingo  = "#D5A6A6"  # Soft pink
pink      = "#DBA8D4"  # Light pink
mauve     = "#B07CC6"  # Purple accent (signature color)
red       = "#E05A5A"  # Error/warning
maroon    = "#D4727A"  # Dark red
peach     = "#D9A076"  # Orange accent
yellow    = "#E0C06E"  # Warning/highlight
green     = "#8FBF9A"  # Success/positive
teal      = "#8AC5C0"  # Cyan variant
sky       = "#89B8D4"  # Light blue
sapphire  = "#7EAAF0"  # Medium blue
blue      = "#7C6FE0"  # Primary blue
lavender  = "#C4A7E7"  # Light purple
```

### Text Colors
```toml
[text]
text     = "#D4D8F0"  # Primary text
subtext1 = "#B8BDD0"  # Secondary text
subtext0 = "#A0A5B8"  # Tertiary text
```

### UI Elements
```toml
[overlay]
overlay2 = "#9399B2"  # UI overlays
overlay1 = "#7F849C"  # Medium overlay
overlay0 = "#6C7086"  # Light overlay

[surface]
surface2 = "#585B70"  # Raised surfaces
surface1 = "#45475A"  # Medium surfaces
surface0 = "#313244"  # Base surfaces

[background]
base   = "#1E1E2E"    # Primary background
mantle = "#181825"    # Secondary background
crust  = "#11111B"    # Deepest background
```

## Theme Variants

### Dark (Default)
The standard dark theme with the full Neu-Alkemy palette. Optimized for low-light environments and extended coding sessions.

**Characteristics**:
- Deep purple-tinted backgrounds
- High contrast for readability
- Purple (`mauve`) as the primary accent color
- Warm undertones for comfort

### Light
A light variant that maintains the Neu-Alkemy aesthetic while providing a bright interface for daytime use.

**Characteristics**:
- Light backgrounds with dark text
- Reduced saturation for eye comfort
- Maintains purple accent theme
- High contrast for outdoor visibility

### Midnight
An ultra-dark variant for minimal distraction and maximum focus.

**Characteristics**:
- Nearly black backgrounds
- Reduced contrast for night use
- Subtle purple accents
- Minimal visual noise

## Application Integration

### Ghostty Terminal
- **Background**: Translucent with blur effect
- **Colors**: Full 16-color palette mapping
- **Cursor**: Accent color with transparency
- **Selection**: Subtle overlay highlighting

### Neovim
- **Syntax Highlighting**: Semantic color mapping
- **UI Elements**: Consistent with terminal theme
- **Transparency**: Matches terminal transparency
- **LSP Integration**: Color-coded diagnostics

### Tmux
- **Status Bar**: Gradient backgrounds with accent highlights
- **Window Indicators**: Color-coded status
- **Pane Borders**: Subtle accent coloring
- **Activity Indicators**: Attention-grabbing highlights

### Starship Prompt
- **Git Status**: Color-coded repository information
- **Directory**: Path highlighting with accents
- **Language Indicators**: Tool-specific coloring
- **Performance**: Execution time highlighting

### AeroSpace
- **Window Borders**: Subtle focus indicators
- **Workspace Indicators**: Color-coded workspace status
- **Focus Highlighting**: Accent color borders

## Usage

### Applying Themes
The theme is automatically applied when stowing packages:
```bash
# Apply all packages with theme
stow -d ~/Neu-Alkemy -t ~ aerospace ghostty nvim tmux zsh

# Apply specific package
stow -d ~/Neu-Alkemy -t ~ nvim
```

### Switching Variants
To switch theme variants:
```bash
# Switch to light variant
cp themes/neu-alkemy/variants/light.toml ~/.config/neu-alkemy/active.toml

# Switch to midnight variant  
cp themes/neu-alkemy/variants/midnight.toml ~/.config/neu-alkemy/active.toml
```

### Manual Application
For tools not automatically themed:
```bash
# Apply Ghostty theme
cp themes/neu-alkemy/apps/ghostty/config ~/.config/ghostty/

# Apply Neovim theme
cp themes/neu-alkemy/apps/nvim/colors.lua ~/.config/nvim/lua/colors.lua
```

## Customization

### Creating Custom Variants
1. **Copy base variant**:
   ```bash
   cp themes/neu-alkemy/variants/dark.toml themes/neu-alkemy/variants/custom.toml
   ```

2. **Modify colors** while maintaining the palette structure

3. **Test with applications** to ensure consistency

### Color Mapping Guidelines
When creating app-specific themes:

- **Primary Background**: Use `base` color
- **Secondary Background**: Use `mantle` or `surface0`
- **Text**: Use `text` for primary, `subtext1` for secondary
- **Accents**: Use `mauve` as primary accent, `blue` as secondary
- **Status Colors**: 
  - Success: `green`
  - Warning: `yellow`
  - Error: `red`
  - Info: `blue`

### Adding New Applications
1. **Create app directory**:
   ```bash
   mkdir themes/neu-alkemy/apps/new-app
   ```

2. **Create theme files** using the palette colors

3. **Test integration** with existing themes

4. **Document color mappings** in app-specific README

## Development

### Color Validation
Ensure color consistency across applications:
```bash
# Check color usage
grep -r "#[0-9A-Fa-f]\{6\}" themes/neu-alkemy/apps/

# Validate against palette
./scripts/validate-colors.sh
```

### Testing Themes
Test theme changes across all applications:
```bash
# Apply test theme
./scripts/apply-theme.sh test

# Revert to default
./scripts/apply-theme.sh neu-alkemy
```

## Design Philosophy

### Aesthetic Goals
- **Cohesive**: Unified visual language across all tools
- **Comfortable**: Reduced eye strain for long coding sessions
- **Distinctive**: Unique purple-dominant palette
- **Professional**: Suitable for work environments
- **Accessible**: High contrast for readability

### Color Psychology
- **Purple (Mauve)**: Creativity, wisdom, mysticism
- **Deep Blues**: Trust, stability, focus
- **Warm Accents**: Energy, enthusiasm, warmth
- **Neutral Grays**: Balance, sophistication, calm

### Technical Considerations
- **Contrast Ratios**: Meet WCAG accessibility guidelines
- **Color Blindness**: Tested with common color vision deficiencies
- **Display Compatibility**: Works across different monitor types
- **Performance**: Optimized for GPU acceleration

## Troubleshooting

### Common Issues

**Colors Not Applying**:
1. Check if theme files are properly stowed
2. Restart applications after theme changes
3. Verify configuration file paths

**Inconsistent Colors**:
1. Ensure all apps use the same palette source
2. Check for hardcoded colors in configurations
3. Validate color hex values

**Performance Issues**:
1. Disable transparency if experiencing lag
2. Reduce color depth for older hardware
3. Check GPU acceleration settings

### Theme Conflicts
If experiencing conflicts with system themes:
1. Disable system dark/light mode switching
2. Override system accent colors
3. Check application-specific theme settings

## Contributing

### Adding Theme Support
When contributing new application themes:
1. **Use the canonical palette** from `palette.toml`
2. **Follow naming conventions** for color variables
3. **Test across variants** (dark, light, midnight)
4. **Document color mappings** in the app's README
5. **Ensure accessibility** standards are met

### Color Modifications
When proposing palette changes:
1. **Maintain contrast ratios** for accessibility
2. **Test across all applications** 
3. **Provide visual examples** of changes
4. **Consider color psychology** implications
5. **Ensure backwards compatibility**

## Resources

### Color Tools
- [Coolors.co](https://coolors.co/) - Palette generation and testing
- [Contrast Ratio](https://contrast-ratio.com/) - Accessibility testing
- [Color Oracle](https://colororacle.org/) - Color blindness simulation

### Design References
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Base inspiration
- [Material Design](https://material.io/design/color/) - Color system principles
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/color) - macOS color standards

### Technical Documentation
- [Terminal Color Codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors) - ANSI color reference
- [Hex Color Reference](https://htmlcolorcodes.com/) - Color code conversions
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html) - Accessibility standards

The Neu-Alkemy theme system provides a foundation for a beautiful, consistent, and functional development environment that reflects both aesthetic sensibility and practical usability.