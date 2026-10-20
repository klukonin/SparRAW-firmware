/* SDP__sdp_init__2 @ 0x8dfe90, 280 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Configuring SDP %d
 *   SDP::sdp_init() the following sdp port is input enabled but output at init value is defined (should be UNDEF): %d
 *   SDP_GPIO_srvs.c
 *   SDP::sdp_init() the following sdp port is output enabled but also interrupt enabled: %d
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, gpio__dump, rgf_reg_880b00, rgf_reg_880b80, sdp__drive_pin, sdp__init_int_ctrl
 */
	.section .text.SDP__sdp_init__2,"ax",@progbits
	.global SDP__sdp_init__2
SDP__sdp_init__2:
	.global L_8dfe90
L_8dfe90:
	push_s blink
L_8dfe92:
	bl.d L_8c02bc
L_8dfe96:
	mov_s r1,0x2
L_8dfe98:
	mov_s r14,r0
L_8dfe9a:
	mov_s r15,0x800ce8
L_8dfea0:
	add2_s r15,r15,r0
L_8dfea2:
	ld_s r13,[r15]
L_8dfea4:
	mov_s r2,0x10082ac
L_8dfeaa:
	mov_s r0,0x0
L_8dfeac:
	bl.d L_8edfcc
L_8dfeb0:
	bmsk r3,r13,0x4
L_8dfeb4:
	ld_s r0,[r15]
L_8dfeb6:
	lsr_s r0,r0,0x5
L_8dfeb8:
	bmsk_s r0,r0,0x2
L_8dfeba:
	breq r0,0x4,L_8dfec6
L_8dfebe:
	bl.d L_8d13dc
L_8dfec2:
	bmsk r1,r13,0x4
	.global L_8dfec6
L_8dfec6:
	ld_s r15,[r15]
L_8dfec8:
	lsr r0,r15,0x8
L_8dfecc:
	bmsk_s r0,r0,0x0
L_8dfece:
	bl.d L_8d154c
L_8dfed2:
	bmsk r1,r13,0x4
L_8dfed6:
	brne r14,0x4,L_8dfeee
L_8dfeda:
	mov_s r0,0x13880
L_8dfee0:
	mov lp_count,r0
L_8dfee4:
	nop_s
L_8dfee6:
	lp L_8dfeee
L_8dfeea:
	nop_s
L_8dfeec:
	nop_s
	.global L_8dfeee
L_8dfeee:
	mov_s r0,0x800ce8
L_8dfef4:
	ld.as r0,[r0,r14]
L_8dfef8:
	lsr_s r0,r0,0x9
L_8dfefa:
	bmsk.f r16,r0,0x1
L_8dfefe:
	cmp.ne r16,0x1
L_8dff02:
	bne_s L_8dff50
L_8dff04:
	bbit1 r15,0x8,L_8dff2e
L_8dff08:
	mov_s r2,0x10082c0
L_8dff0e:
	mov_s r0,0x0
L_8dff10:
	mov_s r1,r0
L_8dff12:
	bl.d L_8edfcc
L_8dff16:
	bmsk r3,r13,0x4
L_8dff1a:
	mov_s r0,blink
L_8dff1c:
	mov_s r2,0x100829c
L_8dff22:
	mov_s r1,0x1416
L_8dff28:
	bl.d L_8c82c0
L_8dff2c:
	mov_s r3,0xd0
	.global L_8dff2e
L_8dff2e:
	mov_s r0,r16
L_8dff30:
	bl.d L_8d13b0
L_8dff34:
	bmsk r1,r13,0x4
L_8dff38:
	brne r14,0x4,L_8dff50
L_8dff3c:
	mov_s r0,0x13880
L_8dff42:
	mov lp_count,r0
L_8dff46:
	nop_s
L_8dff48:
	lp L_8dff50
L_8dff4c:
	nop_s
L_8dff4e:
	nop_s
	.global L_8dff50
L_8dff50:
	mov_s r0,0x800ce8
L_8dff56:
	ld.as r14,[r0,r14]
L_8dff5a:
	lsr_s r14,r14,0xb
L_8dff5c:
	bmsk.f r14,r14,0x1
L_8dff60:
	cmp.ne r14,0x1
L_8dff64:
	bne_s L_8dffa2
L_8dff66:
	bbit0 r15,0x8,L_8dff90
L_8dff6a:
	mov_s r2,0x1008334
L_8dff70:
	mov_s r0,0x0
L_8dff72:
	mov_s r1,r0
L_8dff74:
	bl.d L_8edfcc
L_8dff78:
	bmsk r3,r13,0x4
L_8dff7c:
	mov_s r0,blink
L_8dff7e:
	mov_s r2,0x100829c
L_8dff84:
	mov_s r1,0x1413
L_8dff8a:
	bl.d L_8c82c0
L_8dff8e:
	mov_s r3,0xdd
	.global L_8dff90
L_8dff90:
	mov_s r0,r14
L_8dff92:
	bl.d L_8d1448
L_8dff96:
	bmsk r1,r13,0x4
L_8dff9a:
	bl.d L_8d1430
L_8dff9e:
	bmsk r0,r13,0x4
	.global L_8dffa2
L_8dffa2:
	b L_8c0324
L_8dffa6:
	nop_s
