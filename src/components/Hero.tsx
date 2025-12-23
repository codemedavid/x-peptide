import React, { useEffect, useState } from 'react';
import { ArrowRight, Shield, Zap, Award, ChevronRight } from 'lucide-react';

interface HeroProps {
  onShopAll: () => void;
}

const Hero: React.FC<HeroProps> = ({ onShopAll }) => {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  /* Use hardcoded values as requested, bypassing siteSettings for these specific fields */
  const tagline = 'From First Dose to Real Results.';
  const description = 'Your trusted partner in safe, guided, and goal-driven peptide therapy.';

  return (
    <div className="relative min-h-[90vh] bg-black overflow-hidden">
      {/* Animated Background */}
      <div className="absolute inset-0">
        {/* Gradient Overlays */}
        <div className="absolute inset-0 bg-gradient-to-br from-black via-black to-[#0a0a0a]" />

        {/* Subtle radial glow */}
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-white/[0.02] rounded-full blur-3xl" />

        {/* Floating orbs */}
        <div className="absolute top-20 right-[15%] w-64 h-64 bg-white/[0.03] rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-40 left-[10%] w-48 h-48 bg-white/[0.02] rounded-full blur-3xl animate-float" style={{ animationDelay: '2s' }} />

        {/* Grid pattern */}
        <div className="absolute inset-0 bg-grid-white opacity-[0.1]" />

        {/* Diagonal lines accent */}
        <div className="absolute top-0 right-0 w-1/2 h-full opacity-5">
          <svg className="w-full h-full" preserveAspectRatio="none">
            <pattern id="diagonalLines" patternUnits="userSpaceOnUse" width="40" height="40">
              <path d="M0 40L40 0" stroke="white" strokeWidth="0.5" fill="none" />
            </pattern>
            <rect width="100%" height="100%" fill="url(#diagonalLines)" />
          </svg>
        </div>
      </div>

      {/* Content */}
      <div className="relative z-10 container mx-auto px-4 sm:px-6 lg:px-8 pt-16 sm:pt-24 pb-16">
        <div className="max-w-5xl mx-auto text-center">

          {/* Badge */}
          <div
            className={`inline-flex items-center gap-2 px-5 py-2.5 rounded-full bg-white/5 backdrop-blur-sm border border-white/10 mb-8 transition-all duration-700 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
              }`}
          >
            <span className="w-2 h-2 rounded-full bg-white animate-pulse" />
            <span className="text-sm font-medium text-white/90 tracking-wide">Premium Research Peptides</span>
          </div>

          {/* Main Headline */}
          <h1
            className={`font-outfit text-5xl sm:text-6xl md:text-7xl lg:text-8xl font-black text-white tracking-tighter leading-[0.9] mb-6 transition-all duration-700 delay-100 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            {tagline.split(' ').map((word, i) => (
              <span key={i} className="inline-block">
                {word === 'Real' || word === 'Results.' ? (
                  <span className="text-transparent bg-clip-text bg-gradient-to-r from-white via-gray-300 to-white">{word}</span>
                ) : word}
                {i < tagline.split(' ').length - 1 && ' '}
              </span>
            ))}
          </h1>

          {/* Underline accent */}
          <div
            className={`h-1 w-32 mx-auto bg-gradient-to-r from-transparent via-white to-transparent mb-8 transition-all duration-700 delay-200 ${isVisible ? 'opacity-100 scale-x-100' : 'opacity-0 scale-x-0'
              }`}
          />

          {/* Description */}
          <p
            className={`text-lg sm:text-xl text-gray-400 max-w-2xl mx-auto mb-10 leading-relaxed transition-all duration-700 delay-300 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            {description}
          </p>

          {/* CTA Buttons */}
          <div
            className={`flex flex-col sm:flex-row items-center justify-center gap-4 mb-16 transition-all duration-700 delay-400 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            <button
              onClick={onShopAll}
              className="group relative overflow-hidden bg-white text-black px-10 py-4 rounded-lg font-bold text-sm uppercase tracking-wider transition-all duration-300 shadow-glow hover:shadow-glow-lg transform hover:-translate-y-1"
            >
              <span className="relative z-10 flex items-center gap-2">
                Shop Collection
                <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
              </span>
              <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-700" />
            </button>

            <a
              href="/coa"
              className="group flex items-center gap-2 px-8 py-4 rounded-lg font-semibold text-sm text-white/80 hover:text-white border border-white/20 hover:border-white/40 hover:bg-white/5 transition-all duration-300 backdrop-blur-sm"
            >
              <Shield className="w-4 h-4" />
              View Lab Reports
              <ChevronRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
            </a>
          </div>

          {/* Feature Cards */}
          <div
            className={`grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto transition-all duration-700 delay-500 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            {[
              { icon: Shield, title: 'Lab Tested', desc: '99%+ Purity Verified' },
              { icon: Zap, title: 'Fast Shipping', desc: 'Same-Day Processing' },
              { icon: Award, title: 'Research Grade', desc: 'Premium Quality' }
            ].map((feature, idx) => (
              <div
                key={idx}
                className="group relative p-6 rounded-2xl bg-white/[0.03] backdrop-blur-sm border border-white/10 hover:border-white/25 hover:bg-white/[0.05] transition-all duration-500"
                style={{ transitionDelay: `${600 + idx * 100}ms` }}
              >
                <div className="flex flex-col items-center text-center">
                  <div className="w-14 h-14 rounded-xl bg-white/5 flex items-center justify-center mb-4 group-hover:bg-white/10 transition-colors">
                    <feature.icon className="w-6 h-6 text-white" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-1">{feature.title}</h3>
                  <p className="text-sm text-gray-500">{feature.desc}</p>
                </div>

                {/* Hover glow effect */}
                <div className="absolute inset-0 rounded-2xl bg-gradient-to-b from-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              </div>
            ))}
          </div>

        </div>
      </div>

      {/* Bottom gradient fade */}
      <div className="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-black to-transparent" />
    </div>
  );
};

export default Hero;
