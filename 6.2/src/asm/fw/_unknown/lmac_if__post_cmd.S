/* lmac_if__post_cmd @ 0x8e5204, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_est__stack_args, conn__alloc_and_fill, conn__alloc_and_link, field_rw_0x00__8db534, field_set_0x00__8db5bc, field_set_0x00__8dbc94, field_set_0x00__8dbe88, fixed_sched__start, ftm__send_ucode_session_cfg, ftm_main_sm__radio_allocated_cb
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, wmi_evt__build_and_post
 * Глобалы (через gp): 0x8003c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__post_cmd
lmac_if__post_cmd:
	.global L_8e5204
L_8e5204:
	push_s blink
L_8e5206:
	bl L_8c01d0
L_8e520a:
	sub_s sp,sp,0x4
L_8e520c:
	mov_s r19,r0
L_8e520e:
	ld_s r0,[gp,0x244]
L_8e5210:
	mov_s r17,r2
L_8e5212:
	mov_s r18,r1
L_8e5214:
	mov_s r16,r3
L_8e5216:
	brne r0,0x1,L_8e524c
	.global L_8e521a
L_8e521a:
	mov_s r3,0x0
L_8e521c:
	st_s r3,[sp,0x0]
L_8e521e:
	mov_s r0,0x804280
L_8e5224:
	mov_s r1,r19
L_8e5226:
	mov_s r2,r18
L_8e5228:
	mov r4,r17
L_8e522c:
	mov r5,r16
L_8e5230:
	mov_s r6,r3
L_8e5232:
	bl.d L_8e4ff8
L_8e5236:
	mov_s r7,r3
L_8e5238:
	mov_s r0,0x1
L_8e523a:
	mov_s r1,0x886d80
L_8e5240:
	st_s r0,[r1,0x58]
L_8e5242:
	sync
L_8e5246:
	b.d L_8c022c
L_8e524a:
	add_s sp,sp,0x4
	.global L_8e524c
L_8e524c:
	mov_s r0,blink
L_8e524e:
	mov_s r1,0x46
L_8e5250:
	bl.d L_8c9b28
L_8e5254:
	bset_s r1,r1,0xc
L_8e5256:
	b_s L_8e521a
