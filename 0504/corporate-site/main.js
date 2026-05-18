class DashlinkUI {
  constructor() {
    this.toggle = document.getElementById('dashlink-toggle');
    this.panel = document.getElementById('dashlink-panel');
    if (this.toggle && this.panel) this.init();
  }
  init() {
    this.toggle.addEventListener('click', () => {
      this.panel.classList.toggle('hidden');
      this.toggle.classList.toggle('active');
      this.panel.setAttribute('aria-hidden', this.panel.classList.contains('hidden'));
    });
  }
}

class SearchOverlayUI {
  constructor() {
    this.openBtn = document.getElementById('open-search-btn');
    this.closeBtn = document.getElementById('close-search-btn');
    this.overlay = document.getElementById('search-overlay');
    if (this.openBtn && this.closeBtn && this.overlay) this.init();
  }
  init() {
    this.openBtn.addEventListener('click', () => {
      this.overlay.classList.remove('hidden');
      this.overlay.setAttribute('aria-hidden', 'false');
      this.overlay.querySelector('input').focus();
    });
    this.closeBtn.addEventListener('click', () => {
      this.overlay.classList.add('hidden');
      this.overlay.setAttribute('aria-hidden', 'true');
    });
  }
}

class HeroSliderUI {
  constructor() {
    this.track = document.getElementById('hero-track');
    this.dotsNav = document.getElementById('carousel-indicators');
    if (this.track && this.dotsNav) {
      this.slides = Array.from(this.track.children);
      this.currentIndex = 0;
      this.init();
    }
  }
  init() {
    this.slides.forEach((_, i) => {
      const dotWrap = document.createElement('button');
      dotWrap.classList.add('gauge-indicator');
      dotWrap.setAttribute('tabindex', '0');
      dotWrap.setAttribute('aria-label', 'Slide ' + (i+1));
      const gauge = document.createElement('div');
      gauge.classList.add('gauge-bar');
      dotWrap.appendChild(gauge);
      dotWrap.addEventListener('click', () => this.goToSlide(i));
      this.dotsNav.appendChild(dotWrap);
    });
    this.goToSlide(0);
    this.startAutoSlide();
  }
  goToSlide(index) {
    this.currentIndex = index;
    this.track.style.transform = `translateX(-${index * 100}%)`;
    const gauges = this.dotsNav.querySelectorAll('.gauge-bar');
    gauges.forEach((g, i) => {
      g.style.width = i === index ? '100%' : '0%';
      g.style.transition = i === index ? 'width 5s linear' : 'none';
      if(i === index) {
        setTimeout(() => { g.style.width = '100%'; }, 50); 
      }
    });
  }
  startAutoSlide() {
    setInterval(() => {
      const next = (this.currentIndex + 1) % this.slides.length;
      this.goToSlide(next);
    }, 5000);
  }
}

class ScrollAnimationUI {
  constructor() {
    this.elements = document.querySelectorAll('.fade-up-element, .product-card, .stat-item, .subpage-content');
    if(this.elements.length > 0) this.init();
  }
  init() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('faded-in');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });
    this.elements.forEach(el => {
      el.classList.add('fade-pre-state');
      observer.observe(el);
    });
  }
}

// DynamicPageRouter Removed to prevent FOUC completely.

window.addEventListener('load', () => {
  setTimeout(() => {
    // 다른 프론트엔드 모션 컴포넌트들 초기화
    new SearchOverlayUI();
    new DashlinkUI();
    new HeroSliderUI();
    new ScrollAnimationUI();
  }, 100);
});
