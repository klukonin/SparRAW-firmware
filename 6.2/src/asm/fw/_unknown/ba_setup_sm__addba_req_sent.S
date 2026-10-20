/* ba_setup_sm__addba_req_sent @ 0x8f0aec, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_req_sent() tsf 0x%08x%08x
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, fw_sysassert_fatal, mac_read_tsf64, u_schd__schedule
 * Глобалы (через gp): 0x8002b0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_req_sent
ba_setup_sm__addba_req_sent:
	.global L_8f0aec
L_8f0aec:
	push_s blink
L_8f0aee:
	push_s r13
L_8f0af0:
	sub_s sp,sp,0x8
L_8f0af2:
	mov_s r13,r0
L_8f0af4:
	mov_s r1,sp
L_8f0af6:
	mov_s r0,0x0
L_8f0af8:
	bl.d L_8e9900
L_8f0afc:
	mov_s r2,r0
L_8f0afe:
	ld_s r2,[sp,0x4]
L_8f0b00:
	mov_s r1,0x10137c0
L_8f0b06:
	mov_s r0,0x27
L_8f0b08:
	bl.d L_8dcc80
L_8f0b0c:
	ld_s r3,[sp,0x0]
L_8f0b0e:
	ld_s r0,[r13,0xc]
L_8f0b10:
	brne_s r0,0,L_8f0b32
	.global L_8f0b12
L_8f0b12:
	mov_s r0,0x30c1c
L_8f0b18:
	ld.as r4,[gp,0x4b]
L_8f0b1c:
	mov_s r1,r13
L_8f0b1e:
	mov_s r2,0x0
L_8f0b20:
	mov_s r3,r2
L_8f0b22:
	mov_s r5,r2
L_8f0b24:
	bl.d L_8e0c0c
L_8f0b28:
	mov_s r6,r2
L_8f0b2a:
	st_s r0,[r13,0xc]
L_8f0b2c:
	b.d L_8c025c
L_8f0b30:
	add_s sp,sp,0x8
	.global L_8f0b32
L_8f0b32:
	mov_s r0,blink
L_8f0b34:
	mov_s r1,0x127f
L_8f0b3a:
	bl L_8c9b28
L_8f0b3e:
	b_s L_8f0b12
