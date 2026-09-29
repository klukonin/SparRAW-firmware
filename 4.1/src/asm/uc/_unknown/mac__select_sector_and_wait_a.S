/* mac__select_sector_and_wait_a @ 0x931338, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, internal_tx_step, txss__init_sweep
 * Зовёт сам: uc_spin_until_event
 */
	.section .text.mac__select_sector_and_wait_a,"ax",@progbits
	.global mac__select_sector_and_wait_a
mac__select_sector_and_wait_a:
	.global L_931338
L_931338:
	asl r1,0x1,r0
L_931340:
	asl_s r1,r1,0x8
L_931342:
	or r2,r1,0x27000000
L_93134a:
	ld.as r1,[gp,-0x12]
L_93134e:
	or_s r1,r1,r2
L_931350:
	mov r32,r1
L_931354:
	st.ab r1,[r25,0x4]
L_931358:
	bclr r25,r25,0xa
L_93135c:
	mov_s r2,0x2004000
L_931362:
	mov_s r32,r2
L_931364:
	st.ab r2,[r25,0x4]
L_931368:
	bclr r25,r25,0xa
L_93136c:
	nop_s
L_93136e:
	nop_s
L_931370:
	nop_s
L_931372:
	mov_s r0,0x0
L_931374:
	b.d L_9317fc
L_931378:
	bset_s r0,r0,0xe
L_93137a:
	nop_s
