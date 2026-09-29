/* abif__set_nibble_all_chains @ 0x8d01c8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__set_nibble_all_chains
abif__set_nibble_all_chains:
	.global L_8d01c8
L_8d01c8:
	push_s blink
L_8d01ca:
	bl L_8c01d8
L_8d01ce:
	bic.f r17,r0,0xf
L_8d01d2:
	mov_s r16,r0
L_8d01d4:
	bne_s L_8d0208
	.global L_8d01d6
L_8d01d6:
	mov_s r14,0x88af00
L_8d01dc:
	ld_s r0,[r14,0x64]
L_8d01de:
	mov r13,-0xf1
L_8d01e2:
	and_s r0,r0,r13
L_8d01e4:
	asl r15,r16,0x4
L_8d01e8:
	or_s r0,r0,r15
L_8d01ea:
	st_s r0,[r14,0x64]
L_8d01ec:
	brne r17,0x0,L_8d0212
	.global L_8d01f0
L_8d01f0:
	ld_s r0,[r14,0x70]
L_8d01f2:
	and_s r0,r0,r13
L_8d01f4:
	or_s r0,r0,r15
L_8d01f6:
	st_s r0,[r14,0x70]
L_8d01f8:
	brne r17,0x0,L_8d021c
	.global L_8d01fc
L_8d01fc:
	ld_s r0,[r14,0x7c]
L_8d01fe:
	and_s r0,r0,r13
L_8d0200:
	or_s r0,r0,r15
L_8d0202:
	st_s r0,[r14,0x7c]
L_8d0204:
	b L_8c023c
	.global L_8d0208
L_8d0208:
	mov_s r0,blink
L_8d020a:
	bl.d L_8c9b28
L_8d020e:
	mov_s r1,0xac
L_8d0210:
	b_s L_8d01d6
	.global L_8d0212
L_8d0212:
	mov_s r0,blink
L_8d0214:
	bl.d L_8c9b28
L_8d0218:
	mov_s r1,0xac
L_8d021a:
	b_s L_8d01f0
	.global L_8d021c
L_8d021c:
	mov_s r0,blink
L_8d021e:
	bl.d L_8c9b28
L_8d0222:
	mov_s r1,0xac
L_8d0224:
	b_s L_8d01fc
L_8d0226:
	nop_s
