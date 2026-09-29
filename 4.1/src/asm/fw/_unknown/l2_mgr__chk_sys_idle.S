/* l2_mgr__chk_sys_idle @ 0x8c5838, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::chk_sys_idle: NON IDLE For MID#%d Number of connections:%d
 * Зовут его: L2MGR__system_state_evt_handler, l2mgr__disconnect_done, l2mgr__send_discovery_stopped
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit2, get_g_800242, mid_list__by_mid, mid_list__count_free
 */
	.section .text.l2_mgr__chk_sys_idle,"ax",@progbits
	.global l2_mgr__chk_sys_idle
l2_mgr__chk_sys_idle:
	.global L_8c5838
L_8c5838:
	push_s blink
L_8c583a:
	bl L_8c02c0
L_8c583e:
	bl.d L_8ca258
L_8c5842:
	sub_s sp,sp,0x4
L_8c5844:
	mov_s r1,r0
L_8c5846:
	mov_s r14,sp
L_8c5848:
	bl.d L_8e1140
L_8c584c:
	mov_s r0,r14
L_8c584e:
	mov_s r15,0x1
L_8c5850:
	b_s L_8c5868
	.global L_8c5852
L_8c5852:
	bl.d L_8db194
L_8c5856:
	mov_s r0,r14
L_8c5858:
	bl L_8ca1b0
L_8c585c:
	bl.d L_8ca464
L_8c5860:
	mov_s r13,r0
L_8c5862:
	mov.f r4,r0
L_8c5866:
	bne_s L_8c5878
	.global L_8c5868
L_8c5868:
	bl.d L_8cb680
L_8c586c:
	mov_s r0,r14
L_8c586e:
	brne_s r0,0,L_8c5852
L_8c5870:
	mov_s r0,r15
L_8c5872:
	b.d L_8c032c
L_8c5876:
	add_s sp,sp,0x4
	.global L_8c5878
L_8c5878:
	mov_s r2,0x100c388
L_8c587e:
	mov_s r0,0xb
L_8c5880:
	mov_s r1,0x2
L_8c5882:
	bl.d L_8edff8
L_8c5886:
	ldb_s r3,[r13,0x10]
L_8c5888:
	mov_s r15,0x0
L_8c588a:
	b_s L_8c5868
