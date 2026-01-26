// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-blog",
          title: "blog",
          description: "",
          section: "Navigation",
          handler: () => {
            window.location.href = "/blog/";
          },
        },{id: "nav-projects",
          title: "projects",
          description: "A growing collection of your cool projects.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/projects/";
          },
        },{id: "nav-cv",
          title: "cv",
          description: "PhD in Biochemistry specializing in epigenetics, chromatin biology, and computational analysis of multi-omics data",
          section: "Navigation",
          handler: () => {
            window.location.href = "/cv/";
          },
        },{id: "post-seeing-five-molecular-layers-at-once-how-spatial-mux-seq-caught-development-in-the-act",
        
          title: "Seeing Five Molecular Layers at Once: How Spatial-Mux-seq Caught Development in the Act...",
        
        description: "",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/spatial-mux-seq/";
          
        },
      },{id: "post-the-method-that-taught-biologists-to-code-without-knowing-it",
        
          title: "The Method That Taught Biologists to Code (Without Knowing It)",
        
        description: "",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/bisulfite/";
          
        },
      },{id: "post-what-i-wish-someone-had-told-me-about-tet1-a-computational-thinking-journey",
        
          title: "What I Wish Someone Had Told Me About TET1: A Computational Thinking Journey...",
        
        description: "Three years into my PhD, I finally understood what I was actually measuring. Here&#39;s what clicked.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/tet1-computational-thinking/";
          
        },
      },{id: "post-tracking-glioblastoma-39-s-circular-dna-at-single-cell-resolution",
        
          title: "Tracking Glioblastoma&#39;s Circular DNA at Single-Cell Resolution",
        
        description: "How single-cell epigenomics reveals that Alzheimer&#39;s is fundamentally about regulatory collapse, not just protein aggregates",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2025/glioblastoma-ecdna/";
          
        },
      },{id: "post-epigenomic-breakdown-in-alzheimer-39-s-when-brain-cells-lose-control",
        
          title: "Epigenomic Breakdown in Alzheimer&#39;s: When Brain Cells Lose Control",
        
        description: "How single-cell epigenomics reveals that Alzheimer&#39;s is fundamentally about regulatory collapse, not just protein aggregates",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2025/alzheimers-epigenomics/";
          
        },
      },{id: "projects-rna-seq-analysis",
          title: 'RNA-seq Analysis',
          description: "A decision framework for experimental design and computational analysis",
          section: "Projects",handler: () => {
              window.location.href = "/projects/1_project/";
            },},{id: "projects-dnmt1-knockout-analysis",
          title: 'Dnmt1 Knockout Analysis',
          description: "From transcriptional changes to biological mechanism - a case study in RNA-seq interpretation",
          section: "Projects",handler: () => {
              window.location.href = "/projects/2_project/";
            },},{id: "projects-h4k8ac-chip-seq-analysis",
          title: 'H4K8ac ChIP-seq Analysis',
          description: "How chromatin accessibility shapes adult oligodendrocyte progenitor identity and function",
          section: "Projects",handler: () => {
              window.location.href = "/projects/3_project/";
            },},{
        id: 'social-cv',
        title: 'CV',
        section: 'Socials',
        handler: () => {
          window.open("/assets/pdf/example_pdf.pdf", "_blank");
        },
      },{
        id: 'social-email',
        title: 'email',
        section: 'Socials',
        handler: () => {
          window.open("mailto:%69%70%65%6B.%73%65%6C%63%65%6E@%67%6D%61%69%6C.%63%6F%6D", "_blank");
        },
      },{
        id: 'social-linkedin',
        title: 'LinkedIn',
        section: 'Socials',
        handler: () => {
          window.open("https://www.linkedin.com/in/ipek-selcen-16516948", "_blank");
        },
      },{
        id: 'social-rss',
        title: 'RSS Feed',
        section: 'Socials',
        handler: () => {
          window.open("/feed.xml", "_blank");
        },
      },{
      id: 'light-theme',
      title: 'Change theme to light',
      description: 'Change the theme of the site to Light',
      section: 'Theme',
      handler: () => {
        setThemeSetting("light");
      },
    },
    {
      id: 'dark-theme',
      title: 'Change theme to dark',
      description: 'Change the theme of the site to Dark',
      section: 'Theme',
      handler: () => {
        setThemeSetting("dark");
      },
    },
    {
      id: 'system-theme',
      title: 'Use system default theme',
      description: 'Change the theme of the site to System Default',
      section: 'Theme',
      handler: () => {
        setThemeSetting("system");
      },
    },];
