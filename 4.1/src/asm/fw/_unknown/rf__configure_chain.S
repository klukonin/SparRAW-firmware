/* rf__configure_chain @ 0x8d46f4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if_class__init_board_file_inteface, power_deep_sleep_exit_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rgf_889380_8cd174, rfc__write_chain_field, rfc__write_packed_fields
 */
	.section .text.rf__configure_chain,"ax",@progbits
	.global rf__configure_chain
rf__configure_chain:
	.global L_8d46f4
L_8d46f4:
	push_s blink
L_8d46f6:
	bl.d L_8c02bc
L_8d46fa:
	mov_s r2,0x0
L_8d46fc:
	mov_s r16,r0
L_8d46fe:
	mov_s r13,r1
L_8d4700:
	mov_s r1,0x1
L_8d4702:
	bl.d L_8d0d9c
L_8d4706:
	mov_s r3,r2
L_8d4708:
	cmp_s r13,0x0
L_8d470a:
	mov.ne r13,0x1
L_8d470e:
	add r5,r13,0xa
L_8d4712:
	extb r5,r5
L_8d4716:
	mov_s r0,r16
L_8d4718:
	mov_s r1,0x1
L_8d471a:
	mov_s r2,0x2
L_8d471c:
	mov_s r3,0x7
L_8d471e:
	mov_s r4,r3
L_8d4720:
	mov_s r6,r1
L_8d4722:
	bl.d L_8d0dc4
L_8d4726:
	mov_s r7,r1
L_8d4728:
	mov_s r0,0x47974700
L_8d472e:
	bl.d L_8cd174
L_8d4732:
	mov_s r1,0x17
L_8d4734:
	sync
L_8d4738:
	b.d L_8c0324
L_8d473c:
	mov_s r0,0x1
L_8d473e:
	nop_s
