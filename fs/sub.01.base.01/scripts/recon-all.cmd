\n\n#---------------------------------
# New invocation of recon-all Thu Jun 29 09:52:04 EDT 2017 
#--------------------------------------------
#@# Longitudinal Base Subject Creation Thu Jun 29 09:52:14 EDT 2017
\n mri_diff --notallow-pix --notallow-geo /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.dh.01/mri/rawavg.mgz /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.bl.01/mri/rawavg.mgz \n
\n mri_robust_template --mov /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.bl.01/mri/norm.mgz /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.dh.01/mri/norm.mgz --lta /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.bl.01_to_sub.01.base.01.lta /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.dh.01_to_sub.01.base.01.lta --template /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/norm_template.mgz --average 1 --sat 4.685 \n
\n mri_robust_template --mov /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.bl.01/mri/orig.mgz /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.dh.01/mri/orig.mgz --average 1 --ixforms /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.bl.01_to_sub.01.base.01.lta /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.dh.01_to_sub.01.base.01.lta --noit --template /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/orig.mgz \n
\n mri_concatenate_lta -invert1 sub.01.bl.01_to_sub.01.base.01.lta identity.nofile sub.01.base.01_to_sub.01.bl.01.lta \n
\n mri_concatenate_lta -invert1 sub.01.dh.01_to_sub.01.base.01.lta identity.nofile sub.01.base.01_to_sub.01.dh.01.lta \n
#--------------------------------------------
#@# MotionCor Thu Jun 29 09:54:11 EDT 2017
\n mri_add_xform_to_header -c /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/talairach.xfm /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/orig.mgz /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/orig.mgz \n
#--------------------------------------------
#@# Talairach Thu Jun 29 09:54:14 EDT 2017
\n mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 \n
\n talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm \n
talairach_avi log file is transforms/talairach_avi.log...
\n cp transforms/talairach.auto.xfm transforms/talairach.xfm \n
#--------------------------------------------
#@# Talairach Failure Detection Thu Jun 29 09:56:02 EDT 2017
\n talairach_afd -T 0.005 -xfm transforms/talairach.xfm \n
\n awk -f /Volumes/CFMI-CFS/opt/fs6/bin/extract_talairach_avi_QA.awk /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/talairach_avi.log \n
\n tal_QC_AZS /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/talairach_avi.log \n
#--------------------------------------------
#@# Nu Intensity Correction Thu Jun 29 09:56:03 EDT 2017
\n mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 \n
\n mri_add_xform_to_header -c /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/talairach.xfm nu.mgz nu.mgz \n
#--------------------------------------------
#@# Intensity Normalization Thu Jun 29 09:58:05 EDT 2017
\n mri_normalize -g 1 -mprage -W ctrl_vol.mgz bias_vol.mgz nu.mgz T1.mgz \n
#--------------------------------------------
#@# Skull Stripping Thu Jun 29 10:00:39 EDT 2017
\n mri_robust_template --mov /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.bl.01/mri/brainmask.mgz /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.dh.01/mri/brainmask.mgz --average 0 --ixforms /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.bl.01_to_sub.01.base.01.lta /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/sub.01.dh.01_to_sub.01.base.01.lta --noit --finalnearest --template brainmask_template.mgz \n
\n mri_mask -keep_mask_deletion_edits T1.mgz brainmask_template.mgz brainmask.auto.mgz \n
\n mri_mask -transfer 255 -keep_mask_deletion_edits brainmask.auto.mgz brainmask_template.mgz brainmask.auto.mgz \n
\n cp brainmask.auto.mgz brainmask.mgz \n
#-------------------------------------
#@# EM Registration Thu Jun 29 10:00:53 EDT 2017
\n mri_em_register -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mri_em_register.dat -mask brainmask.mgz norm_template.mgz /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta \n
#--------------------------------------
#@# CA Normalize Thu Jun 29 10:11:25 EDT 2017
\n mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz norm_template.mgz /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz \n
#--------------------------------------
#@# CA Reg Thu Jun 29 10:12:57 EDT 2017
\n mri_ca_register -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z \n
#--------------------------------------
#@# SubCort Seg Thu Jun 29 12:30:54 EDT 2017
\n mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz \n
\n mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/mri/transforms/cc_up.lta sub.01.base.01 \n
#--------------------------------------
#@# Merge ASeg Thu Jun 29 13:25:43 EDT 2017
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Thu Jun 29 13:25:44 EDT 2017
\n mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Thu Jun 29 13:29:17 EDT 2017
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Thu Jun 29 13:29:20 EDT 2017
\n mri_segment -mprage brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Thu Jun 29 13:31:41 EDT 2017
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz \n
#--------------------------------------------
#@# Tessellate lh Thu Jun 29 13:32:25 EDT 2017
\n mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz \n
\n mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix \n
\n rm -f ../mri/filled-pretess255.mgz \n
\n mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix \n
#--------------------------------------------
#@# Tessellate rh Thu Jun 29 13:32:31 EDT 2017
\n mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz \n
\n mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix \n
\n rm -f ../mri/filled-pretess127.mgz \n
\n mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix \n
#--------------------------------------------
#@# Smooth1 lh Thu Jun 29 13:32:37 EDT 2017
\n mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix \n
#--------------------------------------------
#@# Smooth1 rh Thu Jun 29 13:32:46 EDT 2017
\n mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix \n
#--------------------------------------------
#@# Inflation1 lh Thu Jun 29 13:32:53 EDT 2017
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
#--------------------------------------------
#@# Inflation1 rh Thu Jun 29 13:33:20 EDT 2017
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
#--------------------------------------------
#@# QSphere lh Thu Jun 29 13:33:46 EDT 2017
\n mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#--------------------------------------------
#@# QSphere rh Thu Jun 29 13:36:18 EDT 2017
\n mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
#--------------------------------------------
#@# Fix Topology Copy lh Thu Jun 29 13:38:44 EDT 2017
\n cp ../surf/lh.orig.nofix ../surf/lh.orig \n
\n cp ../surf/lh.inflated.nofix ../surf/lh.inflated \n
#--------------------------------------------
#@# Fix Topology Copy rh Thu Jun 29 13:38:44 EDT 2017
\n cp ../surf/rh.orig.nofix ../surf/rh.orig \n
\n cp ../surf/rh.inflated.nofix ../surf/rh.inflated \n
#@# Fix Topology lh Thu Jun 29 13:38:44 EDT 2017
\n mris_fix_topology -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub.01.base.01 lh \n
#@# Fix Topology rh Thu Jun 29 14:35:39 EDT 2017
\n mris_fix_topology -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub.01.base.01 rh \n
\n mris_euler_number ../surf/lh.orig \n
\n mris_euler_number ../surf/rh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm ../surf/lh.inflated \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm ../surf/rh.inflated \n
#--------------------------------------------
#@# Make White Surf lh Thu Jun 29 15:46:41 EDT 2017
\n mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub.01.base.01 lh \n
#--------------------------------------------
#@# Make White Surf rh Thu Jun 29 15:50:44 EDT 2017
\n mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub.01.base.01 rh \n
#--------------------------------------------
#@# Smooth2 lh Thu Jun 29 15:54:26 EDT 2017
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Smooth2 rh Thu Jun 29 15:54:34 EDT 2017
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Thu Jun 29 15:54:42 EDT 2017
\n mris_inflate -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Inflation2 rh Thu Jun 29 15:55:07 EDT 2017
\n mris_inflate -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_inflate.rh.dat ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Thu Jun 29 15:55:33 EDT 2017
\n mris_curvature -w lh.white.preaparc \n
\n mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Thu Jun 29 15:56:39 EDT 2017
\n mris_curvature -w rh.white.preaparc \n
\n mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
\n#-----------------------------------------
#@# Curvature Stats lh Thu Jun 29 15:57:41 EDT 2017
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub.01.base.01 lh curv sulc \n
\n#-----------------------------------------
#@# Curvature Stats rh Thu Jun 29 15:57:46 EDT 2017
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub.01.base.01 rh curv sulc \n
#--------------------------------------------
#@# Sphere lh Thu Jun 29 15:57:52 EDT 2017
\n mris_sphere -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
#--------------------------------------------
#@# Sphere rh Thu Jun 29 16:36:24 EDT 2017
\n mris_sphere -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
#--------------------------------------------
#@# Surf Reg lh Thu Jun 29 17:15:31 EDT 2017
\n mris_register -curv -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /Volumes/CFMI-CFS/opt/fs6/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg \n
#--------------------------------------------
#@# Surf Reg rh Thu Jun 29 17:52:07 EDT 2017
\n mris_register -curv -rusage /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/sub.01.base.01/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /Volumes/CFMI-CFS/opt/fs6/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg \n
#--------------------------------------------
#@# Jacobian white lh Thu Jun 29 18:29:12 EDT 2017
\n mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white \n
#--------------------------------------------
#@# Jacobian white rh Thu Jun 29 18:29:14 EDT 2017
\n mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white \n
#--------------------------------------------
#@# AvgCurv lh Thu Jun 29 18:29:16 EDT 2017
\n mrisp_paint -a 5 /Volumes/CFMI-CFS/opt/fs6/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv \n
#--------------------------------------------
#@# AvgCurv rh Thu Jun 29 18:29:18 EDT 2017
\n mrisp_paint -a 5 /Volumes/CFMI-CFS/opt/fs6/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv \n
#-----------------------------------------
#@# Cortical Parc lh Thu Jun 29 18:29:20 EDT 2017
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 lh ../surf/lh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot \n
#-----------------------------------------
#@# Cortical Parc rh Thu Jun 29 18:29:34 EDT 2017
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 rh ../surf/rh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot \n
#--------------------------------------------
#@# Make Pial Surf lh Thu Jun 29 18:29:49 EDT 2017
\n mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub.01.base.01 lh \n
#--------------------------------------------
#@# Make Pial Surf rh Thu Jun 29 18:43:02 EDT 2017
\n mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub.01.base.01 rh \n
#--------------------------------------------
#@# Surf Volume lh Thu Jun 29 18:55:49 EDT 2017
#--------------------------------------------
#@# Surf Volume rh Thu Jun 29 18:55:53 EDT 2017
#--------------------------------------------
#@# Cortical ribbon mask Thu Jun 29 18:55:57 EDT 2017
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub.01.base.01 \n
#-----------------------------------------
#@# Parcellation Stats lh Thu Jun 29 19:02:32 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub.01.base.01 lh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub.01.base.01 lh pial \n
#-----------------------------------------
#@# Parcellation Stats rh Thu Jun 29 19:03:36 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub.01.base.01 rh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub.01.base.01 rh pial \n
#-----------------------------------------
#@# Cortical Parc 2 lh Thu Jun 29 19:04:36 EDT 2017
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 lh ../surf/lh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 2 rh Thu Jun 29 19:04:54 EDT 2017
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 rh ../surf/rh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Parcellation Stats 2 lh Thu Jun 29 19:05:12 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub.01.base.01 lh white \n
#-----------------------------------------
#@# Parcellation Stats 2 rh Thu Jun 29 19:05:44 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub.01.base.01 rh white \n
#-----------------------------------------
#@# Cortical Parc 3 lh Thu Jun 29 19:06:15 EDT 2017
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 lh ../surf/lh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# Cortical Parc 3 rh Thu Jun 29 19:06:30 EDT 2017
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub.01.base.01 rh ../surf/rh.sphere.reg /Volumes/CFMI-CFS/opt/fs6/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# Parcellation Stats 3 lh Thu Jun 29 19:06:44 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub.01.base.01 lh white \n
#-----------------------------------------
#@# Parcellation Stats 3 rh Thu Jun 29 19:07:15 EDT 2017
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub.01.base.01 rh white \n
#-----------------------------------------
#@# Relabel Hypointensities Thu Jun 29 19:07:46 EDT 2017
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# AParc-to-ASeg aparc Thu Jun 29 19:08:08 EDT 2017
\n mri_aparc2aseg --s sub.01.base.01 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt \n
#-----------------------------------------
#@# AParc-to-ASeg a2009s Thu Jun 29 19:12:52 EDT 2017
\n mri_aparc2aseg --s sub.01.base.01 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s \n
#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Thu Jun 29 19:17:34 EDT 2017
\n mri_aparc2aseg --s sub.01.base.01 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /Volumes/CFMI-CFS/opt/fs6/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Thu Jun 29 19:22:16 EDT 2017
\n apas2aseg --i aparc+aseg.mgz --o aseg.mgz \n
#--------------------------------------------
#@# ASeg Stats Thu Jun 29 19:22:23 EDT 2017
\n mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Volumes/CFMI-CFS/opt/fs6/ASegStatsLUT.txt --subject sub.01.base.01 \n
#-----------------------------------------
#@# WMParc Thu Jun 29 19:25:48 EDT 2017
\n mri_aparc2aseg --s sub.01.base.01 --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz \n
\n mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub.01.base.01 --surf-wm-vol --ctab /Volumes/CFMI-CFS/opt/fs6/WMParcStatsLUT.txt --etiv \n
#--------------------------------------------
#@# BA_exvivo Labels lh Thu Jun 29 19:34:41 EDT 2017
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.V1_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.V2_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.MT_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub.01.base.01 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mris_label2annot --s sub.01.base.01 --hemi lh --ctab /Volumes/CFMI-CFS/opt/fs6/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.entorhinal_exvivo.label --l lh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub.01.base.01 --hemi lh --ctab /Volumes/CFMI-CFS/opt/fs6/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub.01.base.01 lh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub.01.base.01 lh white \n
#--------------------------------------------
#@# BA_exvivo Labels rh Thu Jun 29 19:39:18 EDT 2017
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.V1_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.V2_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.MT_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub.01.base.01 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Volumes/CFMI-CFS/sync/FreeSurfer-Summer-Workshop/fs/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub.01.base.01 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mris_label2annot --s sub.01.base.01 --hemi rh --ctab /Volumes/CFMI-CFS/opt/fs6/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s sub.01.base.01 --hemi rh --ctab /Volumes/CFMI-CFS/opt/fs6/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub.01.base.01 rh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub.01.base.01 rh white \n
