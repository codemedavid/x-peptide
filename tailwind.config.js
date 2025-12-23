/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // X Peptide Premium Black & White Theme
        'theme-bg': '#000000',        // Jet Black (backgrounds)
        'theme-text': '#FFFFFF',      // Pure White (text, icons)
        'theme-accent': '#FFFFFF',    // Pure White (contrast accent)
        'theme-accent-hover': '#E5E5E5', // Light Ash Gray (hover states)
        'theme-secondary': '#0D0D0D', // Near Black (sections, cards)
        'text-secondary': '#B0B0B0',  // Silver Gray (secondary text)

        // Silver/Metallic accent
        silver: {
          50: '#FAFAFA',
          100: '#F5F5F5',
          200: '#E5E5E5',
          300: '#D4D4D4',
          400: '#A3A3A3',
          500: '#737373',
          600: '#525252',
          700: '#404040',
          800: '#262626',
          900: '#171717',
        },
        // Primary scale - white/gray for premium look
        primary: {
          50: '#FFFFFF',
          100: '#FAFAFA',
          200: '#E5E5E5',
          300: '#D4D4D4',
          400: '#A3A3A3',
          500: '#FFFFFF',
          600: '#E5E5E5',
          700: '#D4D4D4',
          800: '#262626',
          900: '#171717',
        },
        // Accent colors - premium black & white
        accent: {
          light: '#F5F5F5',
          DEFAULT: '#FFFFFF',
          dark: '#E5E5E5',
          white: '#FFFFFF',
          black: '#000000',
        },
        // Charcoal for depth
        charcoal: {
          50: '#FAFAFA',
          100: '#F5F5F5',
          200: '#E5E5E5',
          300: '#D4D4D4',
          400: '#525252',
          500: '#262626',
          600: '#1A1A1A',
          700: '#0D0D0D',
          800: '#0A0A0A',
          900: '#000000',
        },
        // Legacy compatibility
        magenta: {
          500: '#FFFFFF',
          400: '#F5F5F5',
        },
        navy: {
          50: '#F5F5F5',
          900: '#000000',
        },
      },
      fontFamily: {
        inter: ['Inter', 'sans-serif'],
        outfit: ['Outfit', 'sans-serif'],
      },
      boxShadow: {
        'soft': '0 2px 15px rgba(255, 255, 255, 0.03)',
        'medium': '0 4px 25px rgba(255, 255, 255, 0.05)',
        'hover': '0 8px 35px rgba(255, 255, 255, 0.08)',
        'glow': '0 0 20px rgba(255, 255, 255, 0.15)',
        'glow-lg': '0 0 40px rgba(255, 255, 255, 0.2)',
        'inner-glow': 'inset 0 0 20px rgba(255, 255, 255, 0.05)',
        'premium': '0 25px 50px -12px rgba(0, 0, 0, 0.8)',
      },
      animation: {
        'fadeIn': 'fadeIn 0.5s ease-out',
        'slideIn': 'slideIn 0.4s ease-out',
        'float': 'float 6s ease-in-out infinite',
        'pulse-glow': 'pulseGlow 2s ease-in-out infinite',
        'shimmer': 'shimmer 2s linear infinite',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0', transform: 'translateY(5px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        slideIn: {
          '0%': { opacity: '0', transform: 'translateX(-10px)' },
          '100%': { opacity: '1', transform: 'translateX(0)' },
        },
        float: {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-10px)' },
        },
        pulseGlow: {
          '0%, 100%': { boxShadow: '0 0 20px rgba(255, 255, 255, 0.1)' },
          '50%': { boxShadow: '0 0 40px rgba(255, 255, 255, 0.25)' },
        },
        shimmer: {
          '0%': { backgroundPosition: '-200% 0' },
          '100%': { backgroundPosition: '200% 0' },
        },
      },
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'shimmer': 'linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent)',
      },
    },
  },
  plugins: [],
}

