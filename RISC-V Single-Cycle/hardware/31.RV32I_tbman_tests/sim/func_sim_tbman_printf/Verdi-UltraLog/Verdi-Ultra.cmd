verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-sv" "-dbdir" "./simv.daidir" "-f" "run.f"
debLoadSimResult \
           /home1/xsse1/project/lab_cpu/week10/hardware/31.RV32I_tbman_tests/sim/func_sim_tbman_printf/wave.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "c_tests_tb" -win $_nTrace1
srcSetScope "c_tests_tb" -delim "." -win $_nTrace1
srcHBSelect "c_tests_tb" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvCreateWindow
verdiSetActWin -win $_nWave3
schCreateWindow -delim "." -win $_nSchema1 -scope "c_tests_tb"
verdiSetActWin -win $_nSchema_4
schSelect -win $_nSchema4 -inst "CPU"
schPushViewIn -win $_nSchema4
schSetOptions -win $_nSchema4 -portName on
schSetOptions -win $_nSchema4 -pinName on
schSetOptions -win $_nSchema4 -instName on
schSetOptions -win $_nSchema4 -localNetName on
schSetOptions -win $_nSchema4 -completeName on
schSetOptions -win $_nSchema4 -parameterList on
schSetOptions -win $_nSchema4 -highContrastMode on
schZoom {24669} {3054} {41410} {15029} -win $_nSchema4
schPopViewUp -win $_nSchema4
schSelect -win $_nSchema4 -inst "CPU"
schPushViewIn -win $_nSchema4
debExit
