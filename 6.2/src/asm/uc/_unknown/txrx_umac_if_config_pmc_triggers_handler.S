/* txrx_umac_if_config_pmc_triggers_handler @ 0x93a7d4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_umac_if_config_pmc_triggers_handler: stop recording
 *   txrx_umac_if_config_pmc_triggers_handler: previous trigger is active
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_uc, pmc__stop_recording, uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txrx_umac_if_config_pmc_triggers_handler
txrx_umac_if_config_pmc_triggers_handler:
	.global L_93a7d4
L_93a7d4:
	push_s blink
L_93a7d6:
	bl.d L_920234
L_93a7da:
	mov_s r1,0xff
L_93a7dc:
	mov_s r14,r0
L_93a7de:
	ldb_s r0,[r0]
L_93a7e0:
	mov_s r13,0x801458
L_93a7e6:
	brne r0,r1,L_93a806
L_93a7ea:
	ldb_s r0,[r14,0x1]
L_93a7ec:
	brne r0,r1,L_93a806
L_93a7f0:
	mov_s r1,0x1001620
L_93a7f6:
	bl.d L_92d13c
L_93a7fa:
	mov_s r0,0x10
L_93a7fc:
	bl L_936134
L_93a800:
	mov_s r0,0x0
L_93a802:
	stb_s r0,[r13,0x10]
L_93a804:
	b_s L_93a82c
	.global L_93a806
L_93a806:
	ldb_s r0,[r13,0x10]
L_93a808:
	breq_s r0,0,L_93a81a
L_93a80a:
	mov_s r1,0x100165c
L_93a810:
	bl.d L_92d13c
L_93a814:
	mov_s r0,0x10
L_93a816:
	bl L_936134
	.global L_93a81a
L_93a81a:
	mov_s r0,r13
L_93a81c:
	mov_s r1,r14
L_93a81e:
	bl.d L_920330
L_93a822:
	mov_s r2,0xc
L_93a824:
	mov_s r0,0x1
L_93a826:
	stb_s r0,[r13,0x10]
L_93a828:
	mov_s r0,0x0
L_93a82a:
	stb_s r0,[r13,0x11]
	.global L_93a82c
L_93a82c:
	b L_9202a4
