/* rx_macq__init @ 0x8d97f4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, rx_macq__bind_all_queues, rx_macq__entry_addr, rx_macq__setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__init
rx_macq__init:
	.global L_8d97f4
L_8d97f4:
	push_s blink
L_8d97f6:
	bl L_8c01e4
L_8d97fa:
	sub_s sp,sp,0x4
L_8d97fc:
	mov_s r13,0x0
L_8d97fe:
	bl.d L_8ccb68
L_8d9802:
	mov_s r0,r13
L_8d9804:
	mov_s r14,r0
L_8d9806:
	st_s r13,[sp,0x0]
L_8d9808:
	mov_s r1,r13
L_8d980a:
	mov_s r2,r13
L_8d980c:
	mov r3,0x520
L_8d9810:
	mov r4,0xc00
L_8d9818:
	mov r5,0x1a5
L_8d981c:
	mov_s r6,r13
L_8d981e:
	bl.d L_8d93a0
L_8d9822:
	mov r7,0x4
L_8d9826:
	mov_s r0,r14
L_8d9828:
	mov_s r1,0x4
L_8d982a:
	bl.d L_8e1298
L_8d982e:
	mov_s r2,r13
L_8d9830:
	bl.d L_8ccb68
L_8d9834:
	mov_s r0,0x1
L_8d9836:
	mov_s r14,r0
L_8d9838:
	st_s r13,[sp,0x0]
L_8d983a:
	mov_s r1,0x1
L_8d983c:
	mov_s r2,0x5
L_8d983e:
	mov r3,0x220
L_8d9842:
	mov r4,0xda5
L_8d984a:
	mov r5,0x189
L_8d984e:
	mov r6,0x4
L_8d9852:
	bl.d L_8d93a0
L_8d9856:
	mov r7,0x4
L_8d985a:
	mov_s r0,r14
L_8d985c:
	mov_s r1,0x4
L_8d985e:
	bl.d L_8e1298
L_8d9862:
	mov_s r2,r13
L_8d9864:
	b.d L_8c0254
L_8d9868:
	add_s sp,sp,0x4
L_8d986a:
	nop_s
