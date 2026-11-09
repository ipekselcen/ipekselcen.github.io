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
        },{id: "post-oncohistones-part-1-the-k27m-mutation",
        
          title: "Oncohistones, part 1: the K27M mutation",
        
        description: "A single lysine-to-methionine swap in histone H3 can reshape chromatin and gene expression across a cancer cell.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/oncohistones-one-residue/";
          
        },
      },{id: "post-what-spatial-mux-seq-adds-to-tissue-epigenomics",
        
          title: "What Spatial-Mux-seq Adds to Tissue Epigenomics",
        
        description: "",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/spatial-mux-seq/";
          
        },
      },{id: "post-what-sequencing-methods-teach-us-about-inference",
        
          title: "What Sequencing Methods Teach Us About Inference",
        
        description: "",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/bisulfite/";
          
        },
      },{id: "post-learning-to-think-beyond-a-linear-tet-pathway",
        
          title: "Learning to Think Beyond a Linear TET Pathway",
        
        description: "A reflection on how the published TET literature changed the way I think about DNA methylation and gene regulation.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/tet1-computational-thinking/";
          
        },
      },{id: "post-reading-glioblastoma-ecdna-at-single-cell-resolution",
        
          title: "Reading Glioblastoma ecDNA at Single-Cell Resolution",
        
        description: "What scCirclehunter can infer about ecDNA-bearing cell populations in glioblastoma from single-cell ATAC-seq data.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2025/glioblastoma-ecdna/";
          
        },
      },{id: "post-reading-epigenomic-changes-across-alzheimer-39-s-disease",
        
          title: "Reading Epigenomic Changes Across Alzheimer&#39;s Disease",
        
        description: "What a multiregion single-cell study suggests about epigenomic changes, cell identity and cognitive resilience in Alzheimer&#39;s disease.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2025/alzheimers-epigenomics/";
          
        },
      },{id: "projects-rna-seq-analysis",
          title: 'RNA-seq Analysis',
          description: "Notes on choosing and interpreting RNA-seq methods.",
          section: "Projects",handler: () => {
              window.location.href = "/projects/1_project/";
            },},{id: "projects-dnmt1-knockout-analysis",
          title: 'Dnmt1 Knockout Analysis',
          description: "RNA-seq analysis of public Dnmt1 knockout data from neonatal OPCs.",
          section: "Projects",handler: () => {
              window.location.href = "/projects/2_project/";
            },},{id: "projects-h4k8ac-chip-seq-analysis",
          title: 'H4K8ac ChIP-seq Analysis',
          description: "H4K8ac ChIP-seq in adult and neonatal oligodendrocyte progenitor cells.",
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
