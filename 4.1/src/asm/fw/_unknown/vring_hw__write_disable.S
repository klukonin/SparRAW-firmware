/* vring_hw__write_disable @ 0x8cd764, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__disable_and_ack
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.vring_hw__write_disable,"ax",@progbits
	.global vring_hw__write_disable
vring_hw__write_disable:
	.global L_8cd764
L_8cd764:
	push_s blink
L_8cd766:
	push_s r13
L_8cd768:
	lr r13,[0xa]
L_8cd76c:
	bclr r2,r13,0x1
L_8cd770:
	flag r2
L_8cd774:
	mov_s r2,0x881c00
L_8cd77a:
	st_s r0,[r2,0x58]
L_8cd77c:
	breq_s r1,0,L_8cd782
L_8cd77e:
	sync
	.global L_8cd782
L_8cd782:
	lr r0,[0xa]
L_8cd786:
	bic r13,r13,-0x3
L_8cd78a:
	or_s r13,r13,r0
L_8cd78c:
	flag r13
L_8cd790:
	b L_8c033c
