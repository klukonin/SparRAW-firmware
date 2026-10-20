/* pcie__dbi_write_shadow @ 0x8e95b4, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dbi_write shadow DS #%d FAILED
 *   hw_boot_configs.c
 * Зовут его: pcie_perst_handler_step
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log__emit1, fw_sysassert_fatal, pcie__dbi_transfer
 */
	.section .text.pcie__dbi_write_shadow,"ax",@progbits
	.global pcie__dbi_write_shadow
pcie__dbi_write_shadow:
	.global L_8e95b4
L_8e95b4:
	push_s blink
L_8e95b6:
	bl L_8c02ac
L_8e95ba:
	mov_s r15,r1
L_8e95bc:
	mov_s r14,r3
L_8e95be:
	mov r17,r4
L_8e95c2:
	mov r16,r5
L_8e95c6:
	sub r1,r6,0x1
L_8e95ca:
	extb r18,r0
L_8e95ce:
	extb_s r15,r15
L_8e95d0:
	extb r19,r2
L_8e95d4:
	extb r20,r3
L_8e95d8:
	mov_s r0,0x1
L_8e95da:
	push_s r0
L_8e95dc:
	mov_s r0,r4
L_8e95de:
	mov_s r2,r18
L_8e95e0:
	mov_s r3,r15
L_8e95e2:
	mov r4,r19
L_8e95e6:
	mov r5,r20
L_8e95ea:
	mov r6,0x1
L_8e95ee:
	bl.d L_8eaae8
L_8e95f2:
	mov r7,r6
L_8e95f6:
	mov_s r13,0x0
L_8e95f8:
	brne_s r0,0,L_8e961e
L_8e95fa:
	mov_s r2,0x1001650
L_8e9600:
	mov_s r0,r13
L_8e9602:
	mov_s r1,r13
L_8e9604:
	bl.d L_8edfcc
L_8e9608:
	mov_s r3,r14
L_8e960a:
	mov_s r0,blink
L_8e960c:
	mov_s r2,0x1001670
L_8e9612:
	mov_s r1,0x11a2
L_8e9618:
	bl.d L_8c82c0
L_8e961c:
	mov_s r3,0xe4
	.global L_8e961e
L_8e961e:
	st_s r13,[sp,0x0]
L_8e9620:
	mov_s r0,r17
L_8e9622:
	mov_s r1,r16
L_8e9624:
	mov_s r2,r18
L_8e9626:
	mov_s r3,r15
L_8e9628:
	mov r4,r19
L_8e962c:
	mov r5,r20
L_8e9630:
	mov r6,0x1
L_8e9634:
	bl.d L_8eaae8
L_8e9638:
	mov r7,r6
L_8e963c:
	brne_s r0,0,L_8e9662
L_8e963e:
	mov_s r2,0x1001650
L_8e9644:
	mov_s r0,0x0
L_8e9646:
	mov_s r1,r0
L_8e9648:
	bl.d L_8edfcc
L_8e964c:
	mov_s r3,r14
L_8e964e:
	mov_s r0,blink
L_8e9650:
	mov_s r2,0x1001670
L_8e9656:
	mov_s r1,0x11a3
L_8e965c:
	bl.d L_8c82c0
L_8e9660:
	mov_s r3,0xf1
	.global L_8e9662
L_8e9662:
	b.d L_8c0304
L_8e9666:
	add_s sp,sp,0x4
