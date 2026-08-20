behavior_name=drift_at_depth
# drift_20.ma

<start:b_arg>
    b_arg: start_when(enum)			2		# See doco below, allowable=0,1,2,3,4,6,7,8,9,10,13
    b_arg: end_action(enum)			2		# 0-quit, 2-resume
	
 ## HOVER TIME - this controls how long we hover/drift
    b_arg: stop_when_hover_for(sec)	3600.0 # terminate hover when depth does not change for
                                          	# this many secs, <0 to disable(not recommended)
						# samedepth for and stalled for abort b_args needs to be longer than this!
						# 43200 = 12 hours;

    b_arg: est_time_to_settle(s)	30.0   # Used to force invalid cc_time_til_inflect for this
                                           # many seconds at the beginning of the behavior.

 ## HOVER DEPTH- this controls the depth that we hover/drift
    b_arg: target_depth(m)			600 # depth to drift at

    b_arg: target_altitude(m)		-1 # altitude to drift at, <=0 disables
    b_arg: alt_time(s)			-1 # time spacing for altimeter pings
                                       # <0 is off, =0 as fast as possible
                                       # >0 that many seconds betweens measurements

    b_arg: target_deadband(m)		100	# +/- around target depth
    b_arg: start_dist_from_target(m)	-1	# start the drift this distance from the target depth/altitude.  
						# -1 means use the target_deadband

   ## Hover - Pump Control 
    b_arg: depth_ctrl(enum)		0	 # 0 = Default mode for buoyancy drive only drift_at_depth. 
										 # Increment by bpump_delta_value
    b_arg: bpump_delta_value(cc)	20.0 # Increments to adjust x_hover_ballast(cc) to obtain neutral buoyancy (>= 1.0 cc).
    b_arg: bpump_delay(s)		90	 # Minimum time between making buoyancy adjustments 
										 
    b_arg: bpump_deadz_width(cc)	30.0	# For temporarily adjusting the buoyancy pump
    b_arg: bpump_db_frac_dz(nodim)	0.667	# Deadband during the drift_at_depth behavior


   ## Hover - Pitch Control
                                   # pitch_mode_t values - battery or fluid fore/aft control
    b_arg: use_pitch(enum) 3       # 4  Fluid Pumped absolute
                                   # 3  Servo on Pitch
                                   # 2  Pitch, set once from curve
                                   # 1  BattPos
    b_arg: pitch_value(X) 0.0	   # use_pitch == 4    cc, clips to max legal, >0 to nose down
                                   # use_pitch == 2,3  rad, desired pitch angle, <0 to dive
                                   # use_pitch == 1    in,  desired battpos, >0 to nose down; clips to max legal
                                                       								   
    b_arg: wait_for_pitch(bool) 0  # if true, we only adjust x_hover_ballast if pitch is within deadband

   ## Hover - Thruster Control
    b_arg: use_thruster(enum)   0  # 0  Not in use
                                   # 1  Command input voltage (as % of glider voltage)
                                   # 2  Command input voltage (as % of max thruster input voltage)	
                                   # 3  N/A for this behavior
                                   # 4  Command input power. See sensors for use_thruster = power										
    b_arg: thruster_value(X)   0   # use_thruster == 0  None
                                   # use_thruster == 1  %, desired % of glider voltage, between [0, 100] (will be clipped to F_THRUSTER_MAX_V)
                                   # use_thruster == 2  %, desired % of F_THRUSTER_MAX_V, between [0, 100] 
                                   # 3  N/A for this behavior
                                   # use_thruster == 4  watt, desired input power, between [1, 9] Watts 

    b_arg: enable_steering(bool) 0 # Enable(1) or disable(0) steering while hovering. 
                                   # Set to True(1) if goto_list or set_heading are to be used.
				   # If False(0), commanded fin position = 0 during hovering.


  ## Dive - Arguments for dive_to hover zone
    b_arg: d_use_bpump(enum)	0		# 0 = Autoballast/Speed control.
    b_arg: d_bpump_value(X)	800		# for use_bpump == 0, total amt of drive to use with autoballast.  Stored as C_AUTOBALLAST_VOLUME
    b_arg: d_use_pitch(enum)	3		# 3 = servo (auto-pitch)
    b_arg: d_pitch_value(X)	-0.4538		# rad, <0 dive
						# -26 deg = -0.4538 rad;


 ## Climb - Arguments for climb_to when climbing to hover zone
	# As we are actually diving to the hover zone, most likely the climb will not be utilized.
	# Instead, drift-at-depth will deactivate after the stop_when_hover_for time elapses, 
	# from which the surface behavior will take over.
    b_arg: c_use_bpump(enum)	0		# 0 = Autoballast/Speed control.
    b_arg: c_use_pitch(enum)	3		# 3 = servo (auto-pitch)
    b_arg: c_pitch_value(X)	0.4538		# rad, >0 climb
						# 26 deg =  0.4538 rad;

<end:b_arg>
