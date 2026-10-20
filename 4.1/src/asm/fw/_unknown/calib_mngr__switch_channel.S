/* calib_mngr__switch_channel @ 0x8c5034, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Switching to channel %d
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, hwm__apply_channel_config, hwm_analog_channel_switch, rf__apply_tx_power, set_g_8000bc
 * Глобалы (через gp): 0x800239, 0x80023b
 */
	.section .text.calib_mngr__switch_channel,"ax",@progbits
	.global calib_mngr__switch_channel
calib_mngr__switch_channel:
	.global L_8c5034
L_8c5034:
	push_s blink
L_8c5036:
	bl.d L_8c02b8
L_8c503a:
	mov_s r1,0x0
L_8c503c:
	mov_s r14,r0
L_8c503e:
	ld_s r0,[gp,-0xb8]
L_8c5040:
	brne r14,r0,L_8c505e
L_8c5044:
	ldb_s r0,[gp,0xc9]
L_8c5046:
	breq_s r0,0,L_8c505e
L_8c5048:
	ld_s r0,[gp,-0x8]
L_8c504a:
	cmp_s r0,0x2
L_8c504c:
	cmp.ne r0,0x3
L_8c5050:
	mov.ne r0,r1
L_8c5054:
	bne_s L_8c50e2
L_8c5056:
	ldb_s r0,[gp,0xcb]
L_8c5058:
	cmp_s r0,0x0
L_8c505a:
	mov_s r0,0x0
L_8c505c:
	bne_s L_8c50e2
	.global L_8c505e
L_8c505e:
	mov_s r15,0x0
L_8c5060:
	stb r15,[gp, 0xae]
L_8c5064:
	mov_s r0,0x1f
L_8c5066:
	mov_s r16,r0
L_8c5068:
	stb r0,[gp, 0xac]
L_8c506c:
	mov_s r0,0x13
L_8c506e:
	mov_s r17,r0
L_8c5070:
	stb r0,[gp, 0xad]
L_8c5074:
	mov_s r2,0x10085e4
L_8c507a:
	mov_s r0,0x6
L_8c507c:
	mov_s r1,0x2
L_8c507e:
	bl.d L_8edfcc
L_8c5082:
	mov_s r3,r14
L_8c5084:
	mov_s r13,0x1
L_8c5086:
	stb r13,[gp, 0xc9]
L_8c508a:
	st.as r14,[gp,-0x2e]
L_8c508e:
	bl.d L_8e1624
L_8c5092:
	mov_s r0,r14
L_8c5094:
	ld_s r0,[gp,-0xb8]
L_8c5096:
	brne_s r0,0,L_8c50a4
L_8c5098:
	stb r13,[gp, 0xae]
L_8c509c:
	mov_s r0,0xa
	.global L_8c509e
L_8c509e:
	stb r0,[gp, 0xac]
L_8c50a2:
	b_s L_8c50ba
	.global L_8c50a4
L_8c50a4:
	brne r0,0x2,L_8c50b0
L_8c50a8:
	stb r13,[gp, 0xae]
L_8c50ac:
	mov_s r0,0xf
L_8c50ae:
	b_s L_8c509e
	.global L_8c50b0
L_8c50b0:
	stb r15,[gp, 0xae]
L_8c50b4:
	stb r16,[gp, 0xac]
L_8c50b8:
	mov_s r0,r17
	.global L_8c50ba
L_8c50ba:
	stb r0,[gp, 0xad]
L_8c50be:
	bl.d L_8d4b3c
L_8c50c2:
	mov_s r0,r14
L_8c50c4:
	bl.d L_8d508c
L_8c50c8:
	mov_s r0,0x1
L_8c50ca:
	ldb_s r0,[gp,0xcb]
L_8c50cc:
	breq r0,0x1,L_8c50da
L_8c50d0:
	ld_s r0,[gp,-0x8]
L_8c50d2:
	cmp_s r0,0x2
L_8c50d4:
	cmp.ne r0,0x3
L_8c50d8:
	bne_s L_8c50e0
	.global L_8c50da
L_8c50da:
	bl.d L_8de0d8
L_8c50de:
	mov_s r0,0x0
	.global L_8c50e0
L_8c50e0:
	mov_s r0,0x1
	.global L_8c50e2
L_8c50e2:
	.byte 0x3d,0x02
