/* hwd_abif__rgf_88af00 @ 0x8cd2d0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: rfc__select_chain_and_write
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88af00,"ax",@progbits
	.global hwd_abif__rgf_88af00
hwd_abif__rgf_88af00:
	.global L_8cd2d0
L_8cd2d0:
	push_s blink
L_8cd2d2:
	bl L_8c02b8
L_8cd2d6:
	bic.f r17,r0,0xf
L_8cd2da:
	mov_s r16,r0
L_8cd2dc:
	bne_s L_8cd310
	.global L_8cd2de
L_8cd2de:
	mov_s r14,0x88af00
L_8cd2e4:
	ld_s r0,[r14,0x64]
L_8cd2e6:
	mov r13,-0xf1
L_8cd2ea:
	and_s r0,r0,r13
L_8cd2ec:
	asl r15,r16,0x4
L_8cd2f0:
	or_s r0,r0,r15
L_8cd2f2:
	st_s r0,[r14,0x64]
L_8cd2f4:
	brne r17,0x0,L_8cd324
	.global L_8cd2f8
L_8cd2f8:
	ld_s r0,[r14,0x70]
L_8cd2fa:
	and_s r0,r0,r13
L_8cd2fc:
	or_s r0,r0,r15
L_8cd2fe:
	st_s r0,[r14,0x70]
L_8cd300:
	brne r17,0x0,L_8cd338
	.global L_8cd304
L_8cd304:
	ld_s r0,[r14,0x7c]
L_8cd306:
	and_s r0,r0,r13
L_8cd308:
	or_s r0,r0,r15
L_8cd30a:
	st_s r0,[r14,0x7c]
L_8cd30c:
	b L_8c031c
	.global L_8cd310
L_8cd310:
	mov_s r0,blink
L_8cd312:
	mov_s r2,0x1019954
L_8cd318:
	mov_s r1,0xac
L_8cd31a:
	mov_s r3,0x0
L_8cd31c:
	bl.d L_8c82c0
L_8cd320:
	bset_s r3,r3,0xb
L_8cd322:
	b_s L_8cd2de
	.global L_8cd324
L_8cd324:
	mov_s r0,blink
L_8cd326:
	mov_s r2,0x1019954
L_8cd32c:
	mov_s r1,0xac
L_8cd32e:
	mov_s r3,0x1
L_8cd330:
	bl.d L_8c82c0
L_8cd334:
	bset_s r3,r3,0xb
L_8cd336:
	b_s L_8cd2f8
	.global L_8cd338
L_8cd338:
	mov_s r0,blink
L_8cd33a:
	mov_s r2,0x1019954
L_8cd340:
	mov_s r1,0xac
L_8cd342:
	mov_s r3,0x2
L_8cd344:
	bl.d L_8c82c0
L_8cd348:
	bset_s r3,r3,0xb
L_8cd34a:
	b_s L_8cd304
