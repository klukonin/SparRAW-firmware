/* vring__read_macq_stats @ 0x8ca944, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_vring_metric
 * Зовёт сам: vring__write_macq_desc
 */
	.section .text.vring__read_macq_stats,"ax",@progbits
	.global vring__read_macq_stats
vring__read_macq_stats:
	.global L_8ca944
L_8ca944:
	push_s blink
L_8ca946:
	sub_s sp,sp,0x30
L_8ca948:
	mov_s r2,sp
L_8ca94a:
	ldb_s r1,[r0]
L_8ca94c:
	mov_s r0,r2
L_8ca94e:
	mov_s r2,0x2
L_8ca950:
	mov_s r3,0x3
L_8ca952:
	bl.d L_8c4768
L_8ca956:
	mov r4,0x1
L_8ca95a:
	ld_s r0,[sp,0x4]
L_8ca95c:
	bmsk_s r0,r0,0xb
L_8ca95e:
	add_s sp,sp,0x30
L_8ca960:
	pop_s blink
L_8ca962:
	j_s [blink]
