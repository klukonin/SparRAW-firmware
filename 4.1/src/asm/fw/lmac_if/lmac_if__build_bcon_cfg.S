/* lmac_if__build_bcon_cfg @ 0x8d80b4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_bcon_mgt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bcn_tx_init_bi_cfg, bcn_tx_init_ss_params
 */
	.section .text.lmac_if__build_bcon_cfg,"ax",@progbits
	.global lmac_if__build_bcon_cfg
lmac_if__build_bcon_cfg:
	.global L_8d80b4
L_8d80b4:
	sub_s sp,sp,0x8
L_8d80b6:
	push_s blink
L_8d80b8:
	bl L_8c02c0
L_8d80bc:
	mov_s r15,r2
L_8d80be:
	mov_s r14,r3
L_8d80c0:
	mov_s r13,r0
L_8d80c2:
	st_s r1,[r0]
L_8d80c4:
	mov_s r1,r2
L_8d80c6:
	bl.d L_8c3d2c
L_8d80ca:
	mov_s r2,r3
L_8d80cc:
	mov_s r0,r13
L_8d80ce:
	mov_s r1,r15
L_8d80d0:
	bl.d L_8c3c98
L_8d80d4:
	mov_s r2,r14
L_8d80d6:
	mov_s r12,0xc
L_8d80d8:
	b L_8c032e
