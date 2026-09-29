/* bi__latch_tsf_and_reset @ 0x92b9d4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x03_handler
 * Зовёт сам: mac__rx_off_seq, uc__set_evt_id_5c, uc_pm__enter_idle, uc_read_tsf_lo, uc_sysassert
 * Глобалы (через gp): 0x800540, 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__latch_tsf_and_reset
bi__latch_tsf_and_reset:
	.global L_92b9d4
L_92b9d4:
	breq.d r0,0x0,L_92ba04
L_92b9d8:
	push_s blink
L_92b9da:
	breq r0,0x1,L_92ba24
L_92b9de:
	mov_s r0,blink
L_92b9e0:
	bl.d L_926618
L_92b9e4:
	mov r1,0x80
L_92b9e8:
	bl L_9364c8
L_92b9ec:
	st.as r0,[gp,0x6]
L_92b9f0:
	mov r0,0x0
L_92b9f4:
	stw.as r0,[gp,0x4a]
L_92b9f8:
	bl.d L_921724
L_92b9fc:
	mov r0,0x1
L_92ba00:
	pop_s blink
L_92ba02:
	j_s [blink]
	.global L_92ba04
L_92ba04:
	bl L_93759c
L_92ba08:
	bl L_9364c8
L_92ba0c:
	st.as r0,[gp,0x6]
L_92ba10:
	mov r0,0x0
L_92ba14:
	stw.as r0,[gp,0x4a]
L_92ba18:
	bl.d L_921724
L_92ba1c:
	mov r0,0x1
L_92ba20:
	pop_s blink
L_92ba22:
	j_s [blink]
	.global L_92ba24
L_92ba24:
	bl.d L_93c7d4
L_92ba28:
	mov r0,0x1
L_92ba2c:
	bl L_9364c8
L_92ba30:
	st.as r0,[gp,0x6]
L_92ba34:
	mov r0,0x0
L_92ba38:
	stw.as r0,[gp,0x4a]
L_92ba3c:
	bl.d L_921724
L_92ba40:
	mov r0,0x1
L_92ba44:
	pop_s blink
L_92ba46:
	j_s [blink]
