verdiSetActWin -dock widgetDock_<Message>
debImport "-f" "run.f"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
wvCreateWindow
verdiSetActWin -win $_nWave2
schCreateWindow -delim "." -win $_nSchema1 -scope "flopenr"
verdiSetActWin -win $_nSchema_3
srcHBSelect "c_tests_tb" -win $_nTrace1
srcSetScope "c_tests_tb" -delim "." -win $_nTrace1
srcHBSelect "c_tests_tb" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvCreateWindow
verdiSetActWin -win $_nWave4
schCreateWindow -delim "." -win $_nSchema1 -scope "c_tests_tb"
verdiSetActWin -win $_nSchema_5
schSelect -win $_nSchema5 -inst "CPU"
schPushViewIn -win $_nSchema5
schSetOptions -win $_nSchema5 -portName on
schSetOptions -win $_nSchema5 -pinName on
schSetOptions -win $_nSchema5 -instName on
schSetOptions -win $_nSchema5 -localNetName on
schSetOptions -win $_nSchema5 -completeName on
schSetOptions -win $_nSchema5 -parameterList on
schSetOptions -win $_nSchema5 -highContrastMode on
schZoom {27096} {23} {40267} {14194} -win $_nSchema5
debExit
