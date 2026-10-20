/* verify_ssid @ 0x8e71ec, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   verify_ssid: length %x %x
 *   verify_ssid: mismatch %x %x %x
 * Зовут его: bss_join_verify
 * Зовёт сам: __ld_r13_ret, fw_log__emit2, fw_log__emit3, memcmp_fw
 */
	.section .text.verify_ssid,"ax",@progbits
	.global verify_ssid
verify_ssid:
	.global L_8e71ec
L_8e71ec:
	push_s blink
L_8e71ee:
	push_s r13
L_8e71f0:
	mov_s r13,r0
L_8e71f2:
	ld r4,[r13, 0x48]
L_8e71f6:
	mov_s r0,r1
L_8e71f8:
	mov_s r3,r2
L_8e71fa:
	breq r2,r4,L_8e7210
L_8e71fe:
	mov_s r2,0x100aff8
L_8e7204:
	mov_s r0,0xb
L_8e7206:
	bl.d L_8edff8
L_8e720a:
	mov_s r1,0x2
L_8e720c:
	mov_s r0,0x0
L_8e720e:
	b_s L_8e723c
	.global L_8e7210
L_8e7210:
	add r1,r13,0x26
L_8e7214:
	bl.d L_8da014
L_8e7218:
	mov_s r2,r4
L_8e721a:
	breq_s r0,0,L_8e723a
L_8e721c:
	add_s r13,r13,0x20
L_8e721e:
	ldb r4,[r13, 0x7]
L_8e7222:
	mov_s r2,0x100b014
L_8e7228:
	ldb r5,[r13, 0x8]
L_8e722c:
	mov_s r0,0xb
L_8e722e:
	mov_s r1,0x2
L_8e7230:
	bl.d L_8ee034
L_8e7234:
	ldb_s r3,[r13,0x6]
L_8e7236:
	mov_s r0,0x0
L_8e7238:
	b_s L_8e723c
	.global L_8e723a
L_8e723a:
	mov_s r0,0x1
	.global L_8e723c
L_8e723c:
	b L_8c033c
