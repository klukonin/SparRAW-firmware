/* lmac_cmd__fill_rx_on_fields @ 0x8dc25c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__build_rx_on_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_cmd__fill_rx_on_fields
lmac_cmd__fill_rx_on_fields:
	.global L_8dc25c
L_8dc25c:
	sub_s sp,sp,0x8
L_8dc25e:
	push_s r13
L_8dc260:
	st_s r2,[r0]
L_8dc262:
	st_s r3,[r0,0x4]
L_8dc264:
	ld_s r2,[r0,0x10]
L_8dc266:
	bmsk r3,r5,0x0
L_8dc26a:
	bclr_s r2,r2,0x0
L_8dc26c:
	or_s r2,r2,r3
L_8dc26e:
	st_s r2,[r0,0x10]
L_8dc270:
	st_s r1,[r0,0x18]
L_8dc272:
	ld_s r1,[r0,0x1c]
L_8dc274:
	bmsk r13,r4,0x0
L_8dc278:
	bclr_s r1,r1,0x0
L_8dc27a:
	or_s r1,r1,r13
L_8dc27c:
	asl_s r13,r13
L_8dc27e:
	bclr_s r1,r1,0x1
L_8dc280:
	or_s r1,r1,r13
L_8dc282:
	bclr_s r1,r1,0x2
L_8dc284:
	st_s r1,[r0,0x1c]
L_8dc286:
	pop_s r13
L_8dc288:
	j_s.d [blink]
L_8dc28a:
	add_s sp,sp,0x8
