/* find_main_sm__bcon_args @ 0x8da8fc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__bcon, ftm_main_sm__action_link_acquisition, l2_mgr__lmac_new_link_evt_handler, scan_mngr__connect, sw_tx_mgmt__acquire_link
 * Зовёт сам: __ld_r13_to_r13_ret, mid__link_acquisition_action
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__bcon_args
find_main_sm__bcon_args:
	.global L_8da8fc
L_8da8fc:
	push_s blink
L_8da8fe:
	push_s r13
L_8da900:
	mov_s r5,r3
L_8da902:
	mov r7,r4
L_8da906:
	mov_s r13,0x0
L_8da908:
	push_s r13
L_8da90a:
	mov r4,sp
L_8da90e:
	mov_s r3,r13
L_8da910:
	bl.d L_8da928
L_8da914:
	mov_s r6,r13
L_8da916:
	cmp_s r0,0x0
L_8da918:
	mov.eq r0,r13
L_8da91c:
	beq_s L_8da920
L_8da91e:
	ld_s r0,[sp,0x0]
	.global L_8da920
L_8da920:
	b.d L_8c025c
L_8da924:
	add_s sp,sp,0x4
L_8da926:
	nop_s
