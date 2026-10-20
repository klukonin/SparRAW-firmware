/* sched__apply_entry @ 0x8f1dc4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysapi_mgr__apply_ut_args
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__start_sysapi_cmd, l2_mgr__high_false_alarm_secondary_lock_cb, mac_read_tsf64, sched__alloc_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__apply_entry
sched__apply_entry:
	.global L_8f1dc4
L_8f1dc4:
	push_s blink
L_8f1dc6:
	bl L_8c01e0
L_8f1dca:
	sub_s sp,sp,0xc
L_8f1dcc:
	mov_s r14,r0
L_8f1dce:
	mov_s r15,r1
L_8f1dd0:
	mov_s r13,r3
L_8f1dd2:
	bl.d L_8f9a20
L_8f1dd6:
	mov_s r1,0x8
L_8f1dd8:
	mov_s r0,0x31e10
L_8f1dde:
	st_s r0,[r14,0x34]
L_8f1de0:
	mov_s r1,sp
L_8f1de2:
	mov_s r0,0x0
L_8f1de4:
	bl.d L_8e9900
L_8f1de8:
	mov_s r2,r0
L_8f1dea:
	mov_s r0,r15
L_8f1dec:
	bl.d L_8db5d8
L_8f1df0:
	ld_s r1,[sp,0x0]
L_8f1df2:
	ld_s r0,[sp,0x0]
L_8f1df4:
	add_s r2,sp,0x8
L_8f1df6:
	st_s r0,[sp,0x8]
L_8f1df8:
	add r4,r14,0x4
L_8f1dfc:
	mov_s r0,r14
L_8f1dfe:
	mov_s r1,0x1
L_8f1e00:
	bl.d L_8f8948
L_8f1e04:
	mov_s r3,0x4
L_8f1e06:
	stw_s r13,[r14,0x6]
L_8f1e08:
	b.d L_8c024c
L_8f1e0c:
	add_s sp,sp,0xc
L_8f1e0e:
	nop_s
L_8f1e10:
	st_s r1,[r0,0x20]
L_8f1e12:
	b.d L_8f3c9c
L_8f1e16:
	mov_s r1,r2
