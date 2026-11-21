function track_ceres
[orb_el, dates] = ceres_orb;
plot_track('Ceres', orb_el, dates)
