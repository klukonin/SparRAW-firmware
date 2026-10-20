/* hwd_abif__rgf_889480_8cd28c @ 0x8cd28c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: rfc__select_chain_and_write
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_889480_8cd28c,"ax",@progbits
	.global hwd_abif__rgf_889480_8cd28c
hwd_abif__rgf_889480_8cd28c:
	.global L_8cd28c
L_8cd28c:
	st.a r16,[sp,-0x4]
L_8cd290:
	mov_s r16,r0
L_8cd292:
	bic.f r0,r0,0xf
L_8cd296:
	push_s blink
L_8cd298:
	bne_s L_8cd2ba
	.global L_8cd29a
L_8cd29a:
	mov_s r2,0x889480
L_8cd2a0:
	ld_s r1,[r2,0x20]
L_8cd2a2:
	asl r0,r16,0x11
L_8cd2a6:
	and r1,r1,0xffe1ffff
L_8cd2ae:
	or_s r0,r0,r1
L_8cd2b0:
	st_s r0,[r2,0x20]
L_8cd2b2:
	pop_s blink
L_8cd2b4:
	j_s.d [blink]
L_8cd2b6:
	ld.ab r16,[sp,0x4]
	.global L_8cd2ba
L_8cd2ba:
	mov_s r0,blink
L_8cd2bc:
	mov_s r2,0x1019954
L_8cd2c2:
	mov_s r1,0xac
L_8cd2c4:
	mov_s r3,0xd
L_8cd2c6:
	bl.d L_8c82c0
L_8cd2ca:
	bset_s r3,r3,0xb
L_8cd2cc:
	b_s L_8cd29a
L_8cd2ce:
	nop_s
