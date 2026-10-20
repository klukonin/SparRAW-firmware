/* hwd_abif__uses_rgf_88af80_8ce660 @ 0x8ce660, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_88af80_8ce660
hwd_abif__uses_rgf_88af80_8ce660:
	.global L_8ce660
L_8ce660:
	push_s blink
L_8ce662:
	push_s r13
L_8ce664:
	mov_s r13,r0
L_8ce666:
	bic.f r0,r0,0x3f
L_8ce66a:
	bne_s L_8ce686
	.global L_8ce66c
L_8ce66c:
	mov_s r1,0x88af80
L_8ce672:
	ld_s r0,[r1,0x34]
L_8ce674:
	asl_s r13,r13,0x8
L_8ce676:
	and r0,r0,0xffffc0ff
L_8ce67e:
	or_s r13,r13,r0
L_8ce680:
	st_s r13,[r1,0x34]
L_8ce682:
	b L_8c025c
	.global L_8ce686
L_8ce686:
	mov_s r0,blink
L_8ce688:
	bl.d L_8c9b28
L_8ce68c:
	mov_s r1,0xac
L_8ce68e:
	b_s L_8ce66c
