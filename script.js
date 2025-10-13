// Smooth scroll with offset for sticky nav
document.querySelectorAll('nav a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const navHeight = document.querySelector('nav').offsetHeight;
            const targetPosition = target.offsetTop - navHeight;
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
});

// Add active class to nav items on scroll
window.addEventListener('scroll', () => {
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('nav a[href^="#"]');
    
    let current = '';
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        if (scrollY >= (sectionTop - 200)) {
            current = section.getAttribute('id');
        }
    });

    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${current}`) {
            link.classList.add('active');
        }
    });
});

// Image lazy loading fallback (for older browsers)
if ('loading' in HTMLImageElement.prototype) {
    const images = document.querySelectorAll('img[loading="lazy"]');
    images.forEach(img => {
        img.src = img.dataset.src;
    });
} else {
    // Fallback for browsers that don't support lazy loading
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/lozad.js/1.16.0/lozad.min.js';
    script.onload = function() {
        const observer = lozad();
        observer.observe();
    };
    document.body.appendChild(script);
}

// Handle Substack form submission (customize URL)
const substackForm = document.querySelector('.substack-form');
if (substackForm) {
    substackForm.addEventListener('submit', function(e) {
        // If you have a Substack URL, uncomment and modify this:
        // const email = this.querySelector('input[type="email"]').value;
        // window.open(`https://your-substack.substack.com/subscribe?email=${encodeURIComponent(email)}`, '_blank');
        
        // For now, prevent default and show message
        e.preventDefault();
        alert('Substack integration coming soon! Follow the project on GitHub for updates.');
    });
}

// Add animation on scroll for elements
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe gallery items and feature cards
document.addEventListener('DOMContentLoaded', () => {
    const animateElements = document.querySelectorAll('.gallery-item, .feature, .essay-card');
    
    animateElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});

// Console Easter egg
console.log('%cFractal Typography', 'font-size: 20px; font-weight: bold; color: #6D0839;');
console.log('%cyo dawg I heard you like type so we put some recursion in yo recursion', 'font-size: 12px; color: #252720;');
console.log('%cso you can type while u type', 'font-size: 12px; color: #6D0839;');
console.log('%cView the source: https://github.com/DRLENSI/fractal_typography', 'font-size: 10px;');
