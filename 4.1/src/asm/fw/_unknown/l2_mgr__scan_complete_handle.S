/* l2_mgr__scan_complete_handle @ 0x8eff7c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::scan_complete_handle()
 *   l2_mgr::scan_complete_handle allow_cids for MID#%d (cids=0x%x)
 * Зовут его: scan_mngr__scan_done
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit0, fw_log__emit2, get_g_800242, lm_if__inject_evt_b, mid_list__by_mid, mid_list__find_by_kind
 */
	.section .text.l2_mgr__scan_complete_handle,"ax",@progbits
	.global l2_mgr__scan_complete_handle
l2_mgr__scan_complete_handle:
	.global L_8eff7c
L_8eff7c:
	push_s blink
L_8eff7e:
	bl L_8c02bc
L_8eff82:
	sub_s sp,sp,0x4
L_8eff84:
	bl.d L_8ca258
L_8eff88:
	mov_s r15,r1
L_8eff8a:
	mov_s r16,r0
L_8eff8c:
	mov_s r2,0x100e128
L_8eff92:
	mov_s r0,0x9
L_8eff94:
	bl.d L_8edfb0
L_8eff98:
	mov_s r1,0x2
L_8eff9a:
	mov_s r13,sp
L_8eff9c:
	mov_s r0,r13
L_8eff9e:
	bl.d L_8e1140
L_8effa2:
	mov_s r1,r16
L_8effa4:
	b_s L_8effba
	.global L_8effa6
L_8effa6:
	bl.d L_8db194
L_8effaa:
	mov_s r0,r13
L_8effac:
	bl L_8ca1b0
L_8effb0:
	mov_s r14,r0
L_8effb2:
	bl.d L_8ca1f8
L_8effb6:
	mov_s r1,0x1
L_8effb8:
	brne_s r0,0,L_8effd4
	.global L_8effba
L_8effba:
	bl.d L_8cb680
L_8effbe:
	mov_s r0,r13
L_8effc0:
	brne_s r0,0,L_8effa6
L_8effc2:
	cmp_s r15,0x0
L_8effc4:
	mov.ne r0,0x3
L_8effc8:
	bl.ne.d L_8e3a08
L_8effcc:
	sub_s.ne r1,r1,r1
L_8effce:
	b.d L_8c0324
L_8effd2:
	add_s sp,sp,0x4
	.global L_8effd4
L_8effd4:
	cmp_s r15,0x0
L_8effd6:
	bl.ne.d L_8de824
L_8effda:
	add2.ne r0,r0,0x19
L_8effde:
	ldb r16,[r14, 0x24]
L_8effe2:
	mov_s r2,0x100e148
L_8effe8:
	ldb_s r3,[r14,0x10]
L_8effea:
	mov_s r0,0x9
L_8effec:
	mov_s r1,0x2
L_8effee:
	bl.d L_8edff8
L_8efff2:
	mov r4,r16
L_8efff6:
	bl.d L_8c2fe4
L_8efffa:
	mov_s r0,r16
L_8efffc:
	b_s L_8effba
L_8efffe:
	nop_s
