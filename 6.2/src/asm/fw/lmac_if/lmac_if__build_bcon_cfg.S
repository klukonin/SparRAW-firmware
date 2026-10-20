/* lmac_if__build_bcon_cfg @ 0x8db260, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_bcon_mgt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bcn_tx_init_bi_cfg, bcn_tx_init_ss_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__build_bcon_cfg
lmac_if__build_bcon_cfg:
	.global L_8db260
L_8db260:
	sub_s sp,sp,0x8
L_8db262:
	push_s blink
L_8db264:
	bl L_8c01e0
L_8db268:
	mov_s r15,r2
L_8db26a:
	mov_s r14,r3
L_8db26c:
	mov_s r13,r0
L_8db26e:
	st_s r1,[r0]
L_8db270:
	mov_s r1,r2
L_8db272:
	bl.d L_8c4664
L_8db276:
	mov_s r2,r3
L_8db278:
	mov_s r0,r13
L_8db27a:
	mov_s r1,r15
L_8db27c:
	bl.d L_8c45d4
L_8db280:
	mov_s r2,r14
L_8db282:
	mov_s r12,0xc
L_8db284:
	b L_8c024e
