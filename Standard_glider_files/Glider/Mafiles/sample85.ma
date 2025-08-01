behavior_name=sample
# sample all science sensors on dive/hover/climb
# 2013-Apr-24 lacooney@alum.mit.edu Modified from sample10.ma
# 2022-Nov-15 ACossio stock Solocam for ver 8.6 gliders
# 2025-Jul-03 jwalsh changed state_to_sample to 15
# 2025-Jul-07 jwalsh changed max_depth to 200 m
# 2025-Jul-07 jwalsh added tod_start and tod_stop values

<start:b_arg>
   b_arg: sensor_type(enum)                 85  # 85  C_SOLOCAM_ON on ver 8.6


                                                # This is a bit-field, combine:
                                                # 8 on_surface, 4 climbing, 2 hovering, 1 diving
    b_arg: state_to_sample(enum)            15   # 0  none
                                                # 7  diving|hovering|climbing
                                                # 15 diving|hovering|climbing|on_surface



    b_arg: intersample_time(s)                0  # if < 0 then off, if = 0 then
                                                 # as fast as possible, and if
                                                 # > 0 then that many seconds
                                                 # between measurements

    b_arg: nth_yo_to_sample(nodim)            1  # After the first yo, sample only
                                                 # on every nth yo. If argument is
                                                 # negative then exclude first yo.

    b_arg: intersample_depth(m)              -1  # supersedes intersample_time
                                                 # by dynamically estimating
                                                 # and setting intersample_time
                                                 # to sample at the specified
                                                 # depth interval. If <=0 then
                                                 # then sample uses
                                                 # intersample_time, if > 0 then
                                                 # that many meters between
                                                 # measurements

    b_arg: min_depth(m)                      -5  # minimum depth to collect data, default
                                                 # is negative to leave on at surface in
                                                 # spite of noise in depth reading
    b_arg: max_depth(m)                    200  # maximum depth to collect data

#    b_arg: sample_time_after_state_change(s)  20  # added per B. Allsup to prevent resets
	
	b_arg: tod_start(hhmm)				   1400	# Time Of Day start hhmm
												#	-1 disabled
												#   hh(00-23) mm(00-59
												#	Pacific: 1400 GMT (7 am)
												#	Antarctic: 0900 GMT (5 am)
	b_arg: tod_stop(hhmm)				   0200	# Time Of Day stop hhmm
												#   hh(00-23) mm(00-59
												#	Pacific: 0200 GMT (7 pm)
												#	Antarctic: 1159 GMT (7:59 pm)

<end:b_arg>
