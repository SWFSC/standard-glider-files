behavior_name=surface

# climb to surface with autoballast values 
# pitch servo'ed to 26 degrees

# Come up when you have completed num_half_cycles_to_do (described in yoXX.ma)
#  or briefly if "yo" finishes, this happens if a bad altimeter hit causes a dive and climb to complete in same cycle

<start:b_arg>

    b_arg: start_when(enum)         2             # BAW_PITCH_IDLE = 2, pitch is idle

    b_arg: end_action(enum)         1             # 0-quit, 1 wait for ^C quit/resume, 2 resume, 3 drift til "end_wpt_dist"
    b_arg: gps_wait_time(s)         300           # how long to wait for gps
    b_arg: keystroke_wait_time(sec) 599           # how long to wait for control-C
    b_arg: printout_cycle_time(sec) 30.0	  # How often to print dialog

 # Climb arguments when this surface behavior becomes active 
   ## Pump arguments
    b_arg: c_use_bpump(enum)	    0 		  # use autoballast on surface climb (requires autoballast yo)

   ## Pitch arguments
    b_arg: c_use_pitch(enum)        3             # 3:servo
    b_arg: c_pitch_value(X)         0.4538        # 26 deg

<end:b_arg>

 
 
   
