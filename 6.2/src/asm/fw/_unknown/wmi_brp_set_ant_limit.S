/* wmi_brp_set_ant_limit @ 0x8dd068, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_BRP_SET_ANT_LIMIT_EVENTID status=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ant_limit__validate, fw_log_emit1, mem_pool__alloc_locked, memset0_words, wmi_brp__alloc_and_store, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_brp_set_ant_limit
wmi_brp_set_ant_limit:
	.global L_8dd068
L_8dd068:
	push_s blink
L_8dd06a:
	bl L_8c01dc
L_8dd06e:
	sub_s sp,sp,0x4
L_8dd070:
	mov_s r15,r0
L_8dd072:
	mov_s r13,r1
L_8dd074:
	mov_s r16,r2
L_8dd076:
	bl.d L_8dd0d0
L_8dd07a:
	mov_s r14,0x1
L_8dd07c:
	brne r0,0x1,L_8dd08c
L_8dd080:
	ldb_s r0,[r13]
L_8dd082:
	ldb_s r1,[r13,0x1]
L_8dd084:
	bl.d L_8db598
L_8dd088:
	ldb_s r2,[r13,0x2]
L_8dd08a:
	mov_s r14,0x0
	.global L_8dd08c
L_8dd08c:
	bl.d L_8c33d0
L_8dd090:
	mov_s r0,r15
L_8dd092:
	mov_s r13,r0
L_8dd094:
	bl.d L_8c1cd8
L_8dd098:
	mov_s r1,0x4
L_8dd09a:
	extb_s r2,r14
L_8dd09c:
	stb_s r14,[r13]
L_8dd09e:
	mov_s r1,0x100675c
L_8dd0a4:
	bl.d L_8dcc10
L_8dd0a8:
	mov_s r0,0x25
L_8dd0aa:
	mov_s r2,0x0
L_8dd0ac:
	st_s r2,[sp,0x0]
L_8dd0ae:
	mov_s r0,r15
L_8dd0b0:
	mov_s r1,r13
L_8dd0b2:
	mov_s r3,0x1924
L_8dd0b8:
	mov r4,0x4
L_8dd0bc:
	mov r5,r16
L_8dd0c0:
	mov_s r6,r2
L_8dd0c2:
	bl.d L_8e4fc4
L_8dd0c6:
	mov_s r7,r2
L_8dd0c8:
	b.d L_8c0244
L_8dd0cc:
	add_s sp,sp,0x4
L_8dd0ce:
	nop_s
