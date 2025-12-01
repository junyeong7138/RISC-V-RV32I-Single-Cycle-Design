verdiSetActWin -dock widgetDock_<Message>
debImport "-sv" "-f" "run.f"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
srcHBSelect "isa_testbench" -win $_nTrace1
srcSetScope "isa_testbench" -delim "." -win $_nTrace1
srcHBSelect "isa_testbench" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvCreateWindow
verdiSetActWin -win $_nWave2
schCreateWindow -delim "." -win $_nSchema1 -scope "isa_testbench"
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "CPU"
schPushViewIn -win $_nSchema3
schSetOptions -win $_nSchema3 -portName on
schSetOptions -win $_nSchema3 -pinName on
schSetOptions -win $_nSchema3 -instName on
schSetOptions -win $_nSchema3 -localNetName on
schSetOptions -win $_nSchema3 -completeName on
schSetOptions -win $_nSchema3 -parameterList on
schSetOptions -win $_nSchema3 -highContrastMode on
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home1/xsse1/project/lab_cpu/week09/hardware/11.RV32I_isa_tests/sim/func_sim/wave.fsdb}
schSelect -win $_nSchema3 -inst "icpu"
schPushViewIn -win $_nSchema3
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -signal "clk"
schAddSelectedToWave -win $_nSchema3 -clipboard
wvDrop -win $_nWave2
schSelect -win $_nSchema3 -signal "n_rst"
schAddSelectedToWave -win $_nSchema3 -clipboard
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 32.855598 -snap {("G2" 0)}
wvZoomOut -win $_nWave2
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
