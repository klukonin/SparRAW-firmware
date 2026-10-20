/* temp_service__radio_locked_cb @ 0x8e20dc, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::radio_locked_cb() m_temp_enabled = FALSE - unlocking radio 0x%x
 *   TEMPERATURE_SERVICE::radio_locked_cb() m_service_stopping = TRUE - unlocking radio 0x%x
 * Зовёт сам: STREAM_MGR__ready_for_modify, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, channels_switch__check_g80017c, fw_log_emit1, perform_first_measurement_operations, radio_mgr__call_method_10, temp__get_active_rf, u_schd__now
 * Глобалы (через gp): 0x80038c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_service__radio_locked_cb
temp_service__radio_locked_cb:
	.global L_8e20dc
L_8e20dc:
	push_s blink
L_8e20de:
	bl L_8c01e4
L_8e20e2:
	mov_s r14,r0
L_8e20e4:
	brne_s r1,0,L_8e2106
L_8e20e6:
	ld_s r0,[gp,-0x10]
L_8e20e8:
	brne_s r0,0,L_8e2106
L_8e20ea:
	mov_s r1,0x10121f8
L_8e20f0:
	mov_s r0,0x1c
L_8e20f2:
	bl.d L_8dcc10
L_8e20f6:
	mov_s r2,r14
L_8e20f8:
	bl.d L_8ea800
L_8e20fc:
	mov_s r0,r14
L_8e20fe:
	mov_s r0,0x0
L_8e2100:
	st.as r0,[gp,-0x11]
L_8e2104:
	b_s L_8e2174
	.global L_8e2106
L_8e2106:
	brne_s r1,0,L_8e212e
L_8e2108:
	ld_s r0,[gp,-0x34]
L_8e210a:
	brne r0,0x1,L_8e212e
L_8e210e:
	mov_s r1,0x1012250
L_8e2114:
	mov_s r0,0x2c
L_8e2116:
	bl.d L_8dcc10
L_8e211a:
	mov_s r2,r14
L_8e211c:
	bl.d L_8ea800
L_8e2120:
	mov_s r0,r14
L_8e2122:
	mov_s r0,0x0
L_8e2124:
	st.as r0,[gp,-0xd]
L_8e2128:
	st.as r0,[gp,-0x11]
L_8e212c:
	b_s L_8e2174
	.global L_8e212e
L_8e212e:
	bl L_8e9524
L_8e2132:
	bl L_8e2348
L_8e2136:
	ld_s r0,[gp,0x208]
L_8e2138:
	cmp_s r0,0x0
L_8e213a:
	bl.eq L_8e0908
L_8e213e:
	bl.d L_8ea800
L_8e2142:
	mov_s r0,r14
L_8e2144:
	ld_s r0,[gp,-0xdc]
L_8e2146:
	mov_s r13,0x0
L_8e2148:
	st.as r13,[gp,-0x11]
L_8e214c:
	breq_s r0,0,L_8e216a
L_8e214e:
	bl.d L_8ccbf4
L_8e2152:
	mov_s r0,r13
L_8e2154:
	mov_s r1,r0
L_8e2156:
	ld.as r3,[gp,-0x37]
L_8e215a:
	ld_s r0,[gp,-0xe0]
L_8e215c:
	jl_s.d [r3]
L_8e215e:
	ld.as r2,[gp,-0x36]
L_8e2162:
	st.as r13,[gp,-0x37]
L_8e2166:
	st.as r13,[gp,-0x36]
	.global L_8e216a
L_8e216a:
	ld_s r0,[gp,-0x10]
L_8e216c:
	breq_s r0,0,L_8e2174
L_8e216e:
	bl.d L_8e494c
L_8e2172:
	ld_s r0,[gp,-0x164]
	.global L_8e2174
L_8e2174:
	b L_8c0254
L_8e2178:
	mov_s r2,r0
L_8e217a:
	mov_s r0,r1
L_8e217c:
	mov_s r1,0x7
L_8e217e:
	mov_s r3,0x0
L_8e2180:
	b.d L_8d9b6c
L_8e2184:
	mov_s r4,r3
L_8e2186:
	nop_s
