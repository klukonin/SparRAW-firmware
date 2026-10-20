/* vring_tbl__entry_addr @ 0x8ccfd8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, ba_sm__action_8c4394, fixed_sched__start, l2mgr__program_assoc_vring, rm_main_sm__enter_primary_non_locked, sm_pring__bind_vring, sm_pring__timeout, sta_psc_sm__action_8c318c, stream_mgr__ready_for_modify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_tbl__entry_addr
vring_tbl__entry_addr:
	.global L_8ccfd8
L_8ccfd8:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8ccfda:
	add_s r0,r0,0x806014
L_8ccfe0:
	j_s [blink]
L_8ccfe2:
	nop_s
