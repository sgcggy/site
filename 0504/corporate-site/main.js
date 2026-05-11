document.addEventListener('DOMContentLoaded', () => {

  // --- 1. Hero Carousel Logic ---
  const track = document.getElementById('hero-track');
  const slides = Array.from(track.children);
  const nextButton = document.getElementById('next-slide');
  const prevButton = document.getElementById('prev-slide');
  const dotsNav = document.getElementById('carousel-indicators');

  let currentSlideIndex = 0;

  // Create indicator dots
  slides.forEach((_, index) => {
    const dot = document.createElement('button');
    dot.classList.add('indicator');
    if (index === 0) dot.classList.add('active');
    dot.setAttribute('aria-label', `Slide ${index + 1}`);
    dotsNav.appendChild(dot);
  });
  
  const dots = Array.from(dotsNav.children);
  slides[0].classList.add('active'); // run intro animation for first slide

  const moveToSlide = (targetIndex) => {
    if (targetIndex < 0) targetIndex = slides.length - 1;
    if (targetIndex >= slides.length) targetIndex = 0;
    
    // remove active animation class
    slides[currentSlideIndex].classList.remove('active');
    
    track.style.transform = 'translateX(-' + targetIndex * 100 + '%)';
    dots[currentSlideIndex].classList.remove('active');
    dots[targetIndex].classList.add('active');
    currentSlideIndex = targetIndex;
    
    // trigger animation
    setTimeout(() => slides[currentSlideIndex].classList.add('active'), 10);
  };

  nextButton.addEventListener('click', () => moveToSlide(currentSlideIndex + 1));
  prevButton.addEventListener('click', () => moveToSlide(currentSlideIndex - 1));

  dots.forEach((dot, index) => {
    dot.addEventListener('click', () => moveToSlide(index));
  });

  // Auto-slide every 5 seconds
  let slideInterval = setInterval(() => moveToSlide(currentSlideIndex + 1), 6000);
  document.querySelector('.hero-carousel').addEventListener('mouseenter', () => clearInterval(slideInterval));
  document.querySelector('.hero-carousel').addEventListener('mouseleave', () => {
    slideInterval = setInterval(() => moveToSlide(currentSlideIndex + 1), 6000);
  });


  // --- 2. Stats Counter Animation ---
  const statValues = document.querySelectorAll('.stat-value[data-target]');
  const animateStats = () => {
    statValues.forEach(value => {
      const target = +value.getAttribute('data-target');
      const speed = 150; 
      const updateCount = () => {
        const current = +value.innerText.replace(/,/g, '');
        const inc = target / speed;
        if (current < target) {
          value.innerText = Math.ceil(current + inc).toLocaleString();
          setTimeout(updateCount, 15);
        } else {
          value.innerText = target.toLocaleString();
        }
      };
      updateCount();
    });
  };

  const observer = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateStats();
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.5 });
  
  const statsSection = document.querySelector('.stats-section');
  if (statsSection) observer.observe(statsSection);


  // --- 3. Tab Navigation Logic ---
  const tabBtns = document.querySelectorAll('.tab-btn');
  const tabPanes = document.querySelectorAll('.tab-pane');

  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      tabBtns.forEach(b => b.classList.remove('active'));
      tabPanes.forEach(p => p.classList.remove('active'));

      btn.classList.add('active');
      const targetId = btn.getAttribute('data-tab');
      document.getElementById(targetId).classList.add('active');
    });
  });

  // --- 4. FAQ Accordion & Search Logic ---
  const faqQuestions = document.querySelectorAll('.faq-question');
  const faqFilterBtns = document.querySelectorAll('.filter-btn');
  const faqItems = document.querySelectorAll('.faq-item');
  const faqSearch = document.getElementById('faq-search');

  // Accordion Toggle
  faqQuestions.forEach(question => {
    question.addEventListener('click', () => {
      const isExpanded = question.getAttribute('aria-expanded') === 'true';
      
      // Close all other accordions first (optional, for accordion strict mode)
      faqQuestions.forEach(q => {
        q.setAttribute('aria-expanded', 'false');
        q.nextElementSibling.style.maxHeight = null;
      });

      // Open clicked one if it wasn't expanded
      if (!isExpanded) {
        question.setAttribute('aria-expanded', 'true');
        const answer = question.nextElementSibling;
        answer.style.maxHeight = answer.scrollHeight + "px";
      }
    });
  });

  // Category Filtering
  faqFilterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      faqFilterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      
      const filterMode = btn.getAttribute('data-filter');
      faqItems.forEach(item => {
        if (filterMode === 'all' || item.getAttribute('data-category') === filterMode) {
          item.style.display = 'block';
        } else {
          item.style.display = 'none';
        }
      });
    });
  });

  // Internal Keyword Search
  if (faqSearch) {
    faqSearch.addEventListener('input', (e) => {
      const val = e.target.value.toLowerCase();
      // Remove filter active state when searching globally
      faqFilterBtns.forEach(b => b.classList.remove('active'));
      document.querySelector('[data-filter="all"]').classList.add('active');

      faqItems.forEach(item => {
        const textContent = item.innerText.toLowerCase();
        if (textContent.includes(val)) {
          item.style.display = 'block';
        } else {
          item.style.display = 'none';
        }
      });
    });
  }

  // --- 5. Newsletter Modal & Form Forms ---
  const modal = document.getElementById('newsletter-modal');
  const openModalBtn = document.getElementById('open-newsletter');
  const closeModalBtn = document.querySelector('.modal-close');
  
  const openModal = () => { modal.classList.add('show'); modal.setAttribute('aria-hidden', 'false'); }
  const closeModal = () => { modal.classList.remove('show'); modal.setAttribute('aria-hidden', 'true'); }

  if (openModalBtn) openModalBtn.addEventListener('click', openModal);
  if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
  if (modal) {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) closeModal();
    });
  }

  const partSearchForm = document.getElementById('part-search-form');
  if (partSearchForm) {
    partSearchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      alert('입력하신 파트 넘버의 데이터시트 검색 화면으로 이동합니다.');
      partSearchForm.reset();
    });
  }

  // --- 6. Mobile Menu Toggle ---
  const menuToggle = document.querySelector('.menu-toggle');
  const gnb = document.querySelector('.gnb');
  if(menuToggle && gnb) {
    menuToggle.addEventListener('click', () => {
      gnb.classList.toggle('active');
    });
  }
});
