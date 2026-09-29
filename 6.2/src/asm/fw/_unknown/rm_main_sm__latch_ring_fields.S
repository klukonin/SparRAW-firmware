/* rm_main_sm__latch_ring_fields @ 0x8d9b44, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_step
 * Глобалы (через gp): 0x8002dc, 0x8002e0, 0x8003d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__latch_ring_fields
rm_main_sm__latch_ring_fields:
	.global L_8d9b44
L_8d9b44:
	ld_s r0,[gp,0x250]
L_8d9b46:
	ld_s r1,[r0,0x10]
L_8d9b48:
	st.as r1,[gp,0x57]
L_8d9b4c:
	ld r0,[r0, 0x88]
L_8d9b50:
	j_s.d [blink]
L_8d9b52:
	st.as r0,[gp,0x56]
L_8d9b56:
	nop_s
