/* rx_queue__setup_ring @ 0x8db7fc, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, rx_queue__program_desc
 */
	.section .text.rx_queue__setup_ring,"ax",@progbits
	.global rx_queue__setup_ring
rx_queue__setup_ring:
	.global L_8db7fc
L_8db7fc:
	push_s blink
L_8db7fe:
	bl.d L_8c02c4
L_8db802:
	mov_s r8,r1
L_8db804:
	mov_s r14,r0
L_8db806:
	mov_s r7,r2
L_8db808:
	mov_s r6,r3
L_8db80a:
	mov r5,r4
L_8db80e:
	ld_s r0,[r0,0x8]
L_8db810:
	mov_s r13,0x84865c
L_8db816:
	ldb_s r1,[r14,0x1]
L_8db818:
	cmp_s r0,0x0
L_8db81a:
	add r0,r13,0x10
L_8db81e:
	mov_s r2,r8
L_8db820:
	mov_s r3,r7
L_8db822:
	mov r4,r6
L_8db826:
	mov r6,0x1
L_8db82a:
	sub.ne r7,r7,r7
L_8db82e:
	mov.eq r6,0x0
L_8db832:
	mov.eq r7,0x1
L_8db836:
	bl L_8df7a4
L_8db83a:
	add r0,r13,0x10
L_8db83e:
	ldb_s r1,[r14]
L_8db840:
	mov_s r2,0x1
L_8db842:
	mov_s r3,0x2
L_8db844:
	mov r4,0x0
L_8db848:
	mov r5,r4
L_8db84c:
	mov r6,r4
L_8db850:
	bl.d L_8c46a4
L_8db854:
	mov_s r7,r2
L_8db856:
	.byte 0xe1,0x02
