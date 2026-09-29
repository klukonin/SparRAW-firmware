/* conn__update_vring_metric @ 0x8de048, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, vring__read_macq_stats, vring_by_index
 */
	.section .text.conn__update_vring_metric,"ax",@progbits
	.global conn__update_vring_metric
conn__update_vring_metric:
L_8de048:
	push_s blink
L_8de04a:
	push_s r13
L_8de04c:
	mov_s r13,r0
L_8de04e:
	bl.d L_8cacc0
L_8de052:
	ldb_s r0,[r0,0x7]
L_8de054:
	bl L_8ca944
L_8de058:
	stw r0,[r13, 0xc8]
L_8de05c:
	add r0,r13,0x10
L_8de060:
	ldb_s r2,[r0]
L_8de062:
	mov_s r1,0x0
L_8de064:
	cmp_s r2,0x1
L_8de066:
	cmp.ne r2,0x3
L_8de06a:
	cmp.ne r2,0x4
L_8de06e:
	bne_s L_8de072
L_8de070:
	mov_s r1,0x1
	.global L_8de072
L_8de072:
	extb.f 0x0,r1
L_8de076:
	mov.ne r1,0x2
L_8de07a:
	sub_s.ne r2,r2,r2
L_8de07c:
	mov.ne r3,r2
L_8de080:
	bl.ne.d L_8d6a1c
L_8de084:
	mov.ne r4,r2
L_8de088:
	b L_8c033c
